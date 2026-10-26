-- 1. An application role that can log in but owns nothing
CREATE ROLE shop_app LOGIN PASSWORD 'shop_app_pwd';

-- 2. The database
CREATE DATABASE shop;
\c shop

-- 3. A schema per bounded context
CREATE SCHEMA catalog;

-- 4. Least privilege: the app can read and write data, but not change the structure
GRANT USAGE ON SCHEMA catalog TO shop_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA catalog
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO shop_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA catalog
    GRANT USAGE, SELECT ON SEQUENCES TO shop_app;

-- 5. So shop_app can write "products" instead of "catalog.products"
ALTER ROLE shop_app SET search_path = catalog;