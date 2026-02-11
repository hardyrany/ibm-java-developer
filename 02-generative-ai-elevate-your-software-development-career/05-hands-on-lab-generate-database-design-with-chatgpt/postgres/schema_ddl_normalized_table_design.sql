-- Active: 1770335747797@@127.0.0.1@5432@postgres

==========================================================================================
Example DDL: Normalized design with addresses (PostgreSQL)
This pattern normalizes addresses into a separate table, 
allowing multiple addresses per customer and easier updates.

===========================================================================================

-- Create database single table design
CREATE DATABASE customer_management_system_ii;

-- Change database
\c customer_management_system_ii

-- Enable extensions (optional)
CREATE EXTENSION IF NOT EXISTS citext;
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create schema in database
CREATE SCHEMA us_customers;
CREATE SCHEMA eu_customers;
CREATE SCHEMA south_america_customers;
CREATE SCHEMA africa_customers;
CREATE SCHEMA asia_customers;

-- Select which schema and create tables and manage
SET search_path TO us_customers, public;

-- Country dimension (optional, for data integrity and uniform codes)
CREATE TABLE countries (
 code CHAR(2) PRIMARY KEY,
 name VARCHAR(100) NOT NULL
);

-- Customers table
CREATE TABLE customers (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 middle_name VARCHAR(100),
 email CITEXT NOT NULL UNIQUE,
 phone VARCHAR(20),
 created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 deleted_at TIMESTAMPTZ
);

-- Addresses table (one or more per customer)
CREATE TABLE addresses (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
 customer_id UUID NOT NULL,
 address_line1 VARCHAR(255) NOT NULL,
 address_line2 VARCHAR(255),
 city VARCHAR(100) NOT NULL,
 state_province VARCHAR(100),
 postal_code VARCHAR(20),
 country_code CHAR(2) NOT NULL,
 is_primary BOOLEAN NOT NULL DEFAULT FALSE,
 created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 deleted_at TIMESTAMPTZ,
 CONSTRAINT fk_addresses_customer FOREIGN KEY (customer_id)
 REFERENCES customers(id) ON DELETE CASCADE,
 CONSTRAINT fk_addresses_country FOREIGN KEY (country_code)
 REFERENCES countries(code)
);



-- Sample queries to common tasks
-- Find a customer and their primary address (normalized design):
SELECT c.id, c.first_name, c.last_name, c.email,
 a.address_line1, a.city, a.country_code
FROM customers c
LEFT JOIN addresses a ON a.customer_id = c.id AND a.is_primary = TRUE
WHERE c.email = 'customer@example.com';


-- Add a new customer with a primary address (normalized design):
BEGIN;
INSERT INTO customers (id, first_name, last_name, email, phone, created_at, updated_at)
VALUES (gen_random_uuid(), 'Jane', 'Doe', 'jane.doe@example.com', NULL, NOW(), NOW());
COMMIT;

-- add countries
INSERT INTO countries (code, name)
VALUES ('US', 'United States');
SELECT * FROM countries;
 code | name
------+----------------
 US   | United States


-- Assume the customer_id is the one just inserted (fetch it via RETURNING in a real script)
-- For clarity, using a placeholder customer_id here
INSERT INTO addresses (id, customer_id, address_line1, city, country_code, is_primary, created_at, updated_at)
VALUES (gen_random_uuid(), '820c561b-2a3e-458d-9813-6e29edd6d1a5', '123 Main St', 'Anytown', 'US', TRUE, NOW(), NOW());


-- Soft delete a customer:
UPDATE customers SET deleted_at = NOW() WHERE id = 'some-uuid';


-- Restore a soft-deleted customer or permanently delete after retention:
-- Restore
UPDATE customers SET deleted_at = NULL WHERE id = 'some-uuid';
-- Permanently delete (after you’ve cleared soft deletes as appropriate)
DELETE FROM addresses WHERE customer_id = 'some-uuid';
DELETE FROM customers WHERE id = 'some-uuid';


-- Option B: Purchases with line items
-- Purchases table (order header)
CREATE TABLE purchases (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
 customer_id UUID NOT NULL,
 purchase_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
 total_amount NUMERIC(12,2) NOT NULL,
 currency CHAR(3) NOT NULL DEFAULT 'USD',
 status VARCHAR(20) NOT NULL DEFAULT 'completed',
 payment_reference VARCHAR(100),
 shipping_cost NUMERIC(12,2) DEFAULT 0,
 tax_amount NUMERIC(12,2) DEFAULT 0,
 created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
 updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
 FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT
);
-- Purchase line items (one row per item in the order)
CREATE TABLE purchase_items (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  purchase_id UUID NOT NULL,
  product_id UUID,
  description VARCHAR(255),
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  unit_price NUMERIC(12,2) NOT NULL CHECK (unit_price >= 0),
  line_total NUMERIC(12,2) NOT NULL CHECK (line_total >= 0),
  FOREIGN KEY (purchase_id) REFERENCES purchases(id) ON DELETE CASCADE
);

-- Optional: FOREIGN KEY (product_id) REFERENCES products(id)
-- Ensure total mechanics (optional, for data integrity):
-- ALTER TABLE purchase_items ADD CONSTRAINT chk_line_total CHECK (line_total = quantity * unit_price);
-- Optional: index for efficient lookups by customer and date
CREATE INDEX idx_purchases_customer_date ON purchases (customer_id, purchase_date);

-- typo in status
-- Fix default (secure)
ALTER TABLE purchases
ALTER COLUMN status SET DEFAULT 'completed';

-- Update existing registry
UPDATE purchases
SET status = 'completed'
WHERE status <> 'completed';

-- guarantee // line_total = quantity * unit_price
ALTER TABLE purchase_items
DROP CONSTRAINT purchase_items_line_total_check;

ALTER TABLE purchase_items
ADD CONSTRAINT chk_line_total
CHECK (line_total = quantity * unit_price);


-- Optional: trigger to auto-update updated_at on row modification for both tables
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
 NEW.updated_at := NOW();
 RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trg_update_customer_updated_at
BEFORE UPDATE ON customers
FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_update_address_updated_at
BEFORE UPDATE ON addresses
FOR EACH ROW EXECUTE FUNCTION update_updated_at();
CREATE TRIGGER trg_purchases_updated
BEFORE UPDATE ON purchases
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();
-- Indexes to speed common queries
CREATE INDEX idx_addresses_customer ON addresses (customer_id);
CREATE INDEX idx_customers_email ON customers (email);