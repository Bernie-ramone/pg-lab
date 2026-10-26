-- Step 1: add it nullable
ALTER TABLE catalog.products ADD COLUMN sku text;

-- Step 2: backfill unique values
WITH numbered AS (
    SELECT id, row_number() OVER (ORDER BY created_at, id) AS n
    FROM catalog.products
)
UPDATE catalog.products p
SET sku = 'SKU-' || lpad(numbered.n::text, 6, '0')
FROM numbered
WHERE p.id = numbered.id;

-- Step 3: tighten the rules
ALTER TABLE catalog.products
    ALTER COLUMN sku SET NOT NULL,
    ADD CONSTRAINT uq_products_sku UNIQUE (sku);