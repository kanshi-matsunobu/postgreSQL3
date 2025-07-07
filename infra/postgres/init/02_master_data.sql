INSERT INTO customers (customer_id, customer_name, gender, age, prefecture) VALUES
(1, 'Alice', 'Female', 25, 'Tokyo'),
(2, 'Bob', 'Male', 35, 'Osaka'),
(3, 'Charlie', 'Male', 45, 'Hokkaido'),
(4, 'Diana', 'Female', 22, 'Fukuoka'),
(5, 'Eve', 'Female', 50, 'Tokyo'),
(6, 'Frank', 'Male', 60, 'Aichi'),
(99, 'John NoPurchase', 'Male', 30, 'California');

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'T-shirt', 'Apparel', 2000),
(2, 'Jeans', 'Apparel', 8000),
(3, 'Sneakers', 'Shoes', 12000),
(4, 'Hat', 'Accessory', 3500),
(5, 'Jacket', 'Apparel', 15000),
(6, 'Dress', 'Apparel', 9000),
(7, 'Sandals', 'Shoes', 6000),
(8, 'Backpack', 'Accessory', 7000),
(9, 'Socks', 'Apparel', 800),
(10, 'Watch', 'Accessory', 20000),
(11, 'Boots', 'Shoes', 18000),
(12, 'Scarf', 'Accessory', 2500);

INSERT INTO employees (employee_id, employee_name, hire_date, manager_id) VALUES
(1, 'Emma Johnson', '2020-04-01', NULL),
(2, 'Liam Smith', '2021-04-01', 1),
(3, 'Olivia Williams', '2022-04-01', 1),
(4, 'Noah Brown', '2019-10-01', NULL),
(5, 'Ava Jones', '2023-01-15', 4),
(6, 'Sophia Garcia', '2021-07-10', NULL),
(7, 'Mason Miller', '2022-09-20', 4),
(8, 'Isabella Davis', '2023-03-05', 1),
(9, 'James Wilson', '2020-11-11', 4),
(10, 'Mia Martinez', '2022-12-12', 6),
(11, 'Benjamin Anderson', '2021-08-08', NULL),
(12, 'Charlotte Thomas', '2023-04-04', 1),
(13, 'Elijah Taylor', '2022-06-06', 6),
(14, 'Amelia Moore', '2021-09-09', 11),
(15, 'Lucas Jackson', '2023-05-05', 4);

INSERT INTO stores (store_id, store_name, prefecture) VALUES
(1, 'Shibuya Store', 'Tokyo'),
(2, 'Umeda Store', 'Osaka'),
(3, 'Sapporo Store', 'Hokkaido');
