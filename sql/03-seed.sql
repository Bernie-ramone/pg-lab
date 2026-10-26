INSERT INTO catalog.categories (name)
VALUES ('Electronics'), ('Audio'), ('Gaming')
RETURNING id, name;

INSERT INTO catalog.products (category_id, name, price, stock)
VALUES
    (1, 'Mechanical Keyboard', 89.99, 120),
    (2, 'Wireless Headphones', 149.50, 60),
    (3, 'Game Controller',     59.99, 200)
RETURNING id, name, created_at;

SELECT p.name, c.name AS category, p.price, p.stock
FROM catalog.products p
JOIN catalog.categories c ON c.id = p.category_id
ORDER BY p.price DESC;