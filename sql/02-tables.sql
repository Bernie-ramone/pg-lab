CREATE TABLE catalog.categories (
    id    bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name  text   NOT NULL UNIQUE
);

CREATE TABLE catalog.products (
    id           uuid          PRIMARY KEY DEFAULT uuidv7(),
    category_id  bigint        NOT NULL REFERENCES catalog.categories (id),
    name         text          NOT NULL,
    price        numeric(10,2) NOT NULL CHECK (price > 0),
    stock        integer       NOT NULL DEFAULT 0 CHECK (stock >= 0),
    created_at   timestamptz   NOT NULL DEFAULT now()
);

-- Postgres does NOT index foreign key columns automatically. You must do it yourself.
CREATE INDEX ix_products_category_id ON catalog.products (category_id);