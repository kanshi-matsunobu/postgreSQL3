INSERT INTO store_sales (sale_id, sale_date, store_id, customer_id, product_id, employee_id, quantity, amount)
SELECT
    i,
    NOW() - (random() * 365)::integer * interval '1 day',
    FLOOR(random() * 3) + 1,            -- store_id: 1～3
    FLOOR(random() * 6) + 1,            -- customer_id: 1～6
    FLOOR(random() * 12) + 1,           -- product_id: 1～12
    FLOOR(random() * 15) + 1,           -- employee_id: 1～15
    FLOOR(random() * 3) + 1,            -- quantity: 1～3
    (random() * 10000 + 2000)::integer
FROM generate_series(1, 2000) AS i;

INSERT INTO online_sales (sale_id, sale_date, customer_id, product_id, quantity, amount)
SELECT
    i + 2000,
    NOW() - (random() * 365)::integer * interval '1 day',
    FLOOR(random() * 6) + 1,            -- customer_id: 1～6
    FLOOR(random() * 12) + 1,           -- product_id: 1～12
    FLOOR(random() * 3) + 1,            -- quantity: 1～3
    (random() * 10000 + 2000)::integer
FROM generate_series(1, 2000) AS i;
