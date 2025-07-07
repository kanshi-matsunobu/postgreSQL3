CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    gender VARCHAR(10),
    age INTEGER,
    prefecture VARCHAR(255)
);
COMMENT ON TABLE customers IS '顧客';
COMMENT ON COLUMN customers.customer_id IS '顧客ID';
COMMENT ON COLUMN customers.customer_name IS '顧客名';
COMMENT ON COLUMN customers.gender IS '性別';
COMMENT ON COLUMN customers.age IS '年齢';
COMMENT ON COLUMN customers.prefecture IS '都道府県';

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(255),
    price INTEGER
);
COMMENT ON TABLE products IS '商品';
COMMENT ON COLUMN products.product_id IS '商品ID';
COMMENT ON COLUMN products.product_name IS '商品名';
COMMENT ON COLUMN products.category IS '商品カテゴリ';
COMMENT ON COLUMN products.price IS '価格';

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    hire_date DATE,
    manager_id INTEGER REFERENCES employees(employee_id)
);
COMMENT ON TABLE employees IS '従業員';
COMMENT ON COLUMN employees.employee_id IS '従業員ID';
COMMENT ON COLUMN employees.employee_name IS '従業員名';
COMMENT ON COLUMN employees.hire_date IS '採用日';
COMMENT ON COLUMN employees.manager_id IS 'マネージャーID';

CREATE TABLE stores (
    store_id INTEGER PRIMARY KEY,
    store_name VARCHAR(255) NOT NULL,
    prefecture VARCHAR(255)
);
COMMENT ON TABLE stores IS '店舗';
COMMENT ON COLUMN stores.store_id IS '店舗ID';
COMMENT ON COLUMN stores.store_name IS '店舗名';
COMMENT ON COLUMN stores.prefecture IS '都道府県';

CREATE TABLE store_sales (
    sale_id INTEGER PRIMARY KEY,
    sale_date DATE NOT NULL,
    store_id INTEGER REFERENCES stores(store_id),
    customer_id INTEGER REFERENCES customers(customer_id),
    product_id INTEGER REFERENCES products(product_id),
    employee_id INTEGER REFERENCES employees(employee_id),
    quantity INTEGER,
    amount INTEGER
);
COMMENT ON TABLE store_sales IS '店舗売上';
COMMENT ON COLUMN store_sales.sale_id IS '売上ID';
COMMENT ON COLUMN store_sales.sale_date IS '売上日';
COMMENT ON COLUMN store_sales.store_id IS '店舗ID';
COMMENT ON COLUMN store_sales.customer_id IS '顧客ID';
COMMENT ON COLUMN store_sales.product_id IS '商品ID';
COMMENT ON COLUMN store_sales.employee_id IS '従業員ID';
COMMENT ON COLUMN store_sales.quantity IS '販売数量';
COMMENT ON COLUMN store_sales.amount IS '売上額';

CREATE TABLE online_sales (
    sale_id INTEGER PRIMARY KEY,
    sale_date DATE NOT NULL,
    customer_id INTEGER REFERENCES customers(customer_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER,
    amount INTEGER
);
COMMENT ON TABLE online_sales IS 'オンライン売上';
COMMENT ON COLUMN online_sales.sale_id IS '売上ID';
COMMENT ON COLUMN online_sales.sale_date IS '売上日';
COMMENT ON COLUMN online_sales.customer_id IS '顧客ID';
COMMENT ON COLUMN online_sales.product_id IS '商品ID';
COMMENT ON COLUMN online_sales.quantity IS '販売数量';
COMMENT ON COLUMN online_sales.amount IS '売上額';
