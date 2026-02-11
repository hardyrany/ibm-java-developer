============================================================================================================
Below is a practical guide to designing a robust customers table for a company.
It covers core principles, two common schema patterns (single table vs normalized with addresses),
recommended fields and data types, constraints, indexing, as well as privacy and operational considerations.
Use these ideas as a starting point and adapt to your tech stack and business rules.
============================================================================================================

## Core design principles

* Minimize redundancy through normalization where appropriate.
* Choose a primary key that supports future growth (UUIDs are common in distributed systems).
* Store essential PII (like emails) with careful constraints and privacy controls.
* Make essential fields NOT NULL; optional fields can be NULL to keep inserts simple.
* Track lifecycle with created\_at and updated\_at timestamps; consider deleted\_at for soft deletes.
* Normalize location data to support broad geographic queries and data consistency.
* Plan for auditing, consent flags, and data retention requirements early.
* Design for searchability: index key fields (email, last name, location) and consider full-text search for names.
* Consider internationalization: use UTF-8, stable country codes, and locale-aware sorting where relevant.

## Schema design options

* Option A: Single table with embedded address fields. Simpler to implement but less flexible if customers can have multiple addresses.
* Option B: Normalized model with a separate addresses table (and optionally a country/cities dimension). More flexible for multiple addresses per customer and for future expansions (e.g., shipping and billing addresses, or multiple contact points).
* Trade-offs:
  \*\* Simpler single-table design is easy to query but can complicate updates if an address changes and may duplicate address data across customers.
  \*\* Normalized design reduces redundancy, improves integrity, and supports multiple addresses per customer but requires joins and more complex migrations.

## Recommended fields and data types

* Primary key: id (UUID or BIGINT depending on your system) — serves as the durable, universal identifier.
* Personal name fields: first\_name, last\_name, optional middle\_name for better parsing and display.
* Contact: email (store in a case-insensitive manner and enforce uniqueness).
* Optional contact: phone\_number.
* Location: design dependent (see options below).
* Timestamps: created\_at, updated\_at; optional deleted\_at for soft deletes.
* Optional metadata: preferences, consent flags, and a data privacy flag if needed.

## Common field naming patterns:

* id: UUID or BIGINT
* first\_name, last\_name, middle\_name: VARCHAR(100–150)
* email: VARCHAR(255) or a case-insensitive type
* phone: VARCHAR(20)
* address\_line1, address\_line2, city, state\_province, postal\_code: VARCHAR(100–255)
* country\_code: CHAR(2) or VARCHAR depending on your country code standard
* created\_at, updated\_at, deleted\_at: TIMESTAMP WITH TIME ZONE (TIMESTAMPTZ)


## Tasks to do:

* task_1 :
Could you provide guidance on designing a database table for the company's customers, including fields like name, email, and location
* task_2:
Can you please give the above in a table format
* task_3:
Could you demonstrate the structure of a database table of the company's customers, outlining the fields like name, email, and location in a clear table format
* task_4:
Regarding the database structure, how should I design a separate 'Purchases' table to store information about customer purchases, such as the date of purchase, amount, and so on? What would be the be

## Database Design

* database = customer_management_system
                database = mysql
                database = postgres
                database = mongodb

* schema
    schema_mysql
              
    schema_postgres
    schema_mongodb
