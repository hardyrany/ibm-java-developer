=============================================================================
Example DDL: Single-table design (PostgreSQL)
This pattern stores a single row per customer with address fields embedded. 
It is simple to start with but limits multi-address support.

===============================================================================


--- Create database single table design
CREATE DATABASE customer_management_system;

-- Change database
\c customer_management_system

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
SET search_path TO africa_customers, public;

-- Countries reference table (optional, for data consistency)
CREATE TABLE countries (
 code CHAR(2) PRIMARY KEY,
 name VARCHAR(100) NOT NULL
);

-- Main customers table with embedded address fields
CREATE TABLE customers (
 id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
 first_name VARCHAR(100) NOT NULL,
 last_name VARCHAR(100) NOT NULL,
 middle_name VARCHAR(100),
 email CITEXT NOT NULL UNIQUE, -- case-insensitive unique emails
 phone VARCHAR(20),
 -- Embedded address fields (single address per customer)
 address_line1 VARCHAR(255),
 address_line2 VARCHAR(255),
 city VARCHAR(100),
 state_province VARCHAR(100),
 postal_code VARCHAR(20),
 country_code CHAR(2) NOT NULL,
 created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 deleted_at TIMESTAMPTZ
);

-- Optional foreign key to countries for data integrity
ALTER TABLE customers
 ADD CONSTRAINT fk_customers_country
 FOREIGN KEY (country_code) REFERENCES countries(code);
 
-- Optional: trigger to auto-update updated_at on row modification
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

-- Index to speed up lookups by email
CREATE UNIQUE INDEX idx_customers_email ON customers (email);


-- Option A: Simple purchases table
-- Purchases (one row per purchase)
CREATE TABLE purchases (
 id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 customer_id BIGINT NOT NULL,
 purchase_date TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
 amount NUMERIC(12,2) NOT NULL,
 currency CHAR(3) NOT NULL DEFAULT 'USD',
 status VARCHAR(20) NOT NULL DEFAULT 'completed',
 payment_reference VARCHAR(100),
 shipping_cost NUMERIC(12,2) DEFAULT 0,
 tax_amount NUMERIC(12,2) DEFAULT 0,
 created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
 updated_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
 FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE RESTRICT
);
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
