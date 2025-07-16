-- 実践課題03: 発展的なSQLクエリ - 課題

-- 課題の解答
--1.  UNION ALLと基本的な集計
--店舗売上とオンライン売上を合算し、全体の売上合計額と販売数量合計を計算してください。
SELECT
    SUM(amount) AS total_sales_amounts,
    SUM(quantity) AS total_quantitys
FROM(
    SELECT amount, quantity
    FROM store_sales
    UNION ALL
    SELECT amount, quantity
    FROM online_sales
) AS combined_sales;

--2.  LEFT JOINとNULL
--店舗またはオンラインで一度も商品を購入したことがない顧客をすべて見つけてください。顧客IDと顧客名を表示してください。
SELECT customers.customer_id,
       customers.customer_name
FROM customers
    LEFT JOIN store_sales ON customers.customer_id = store_sales.customer_id
    LEFT JOIN online_sales ON customers.customer_id = online_sales.customer_id
WHERE store_sales.sale_id IS NULL AND online_sales.sale_id IS NULL;

--3.  CASEと集計
--売上額に基づいて、売上を「高」（10000円以上）、「中」（5000円以上）、「低」（5000円未満）の3つのカテゴリに分類してください。店舗売上とオンライン売上を合算した各カテゴリの売上件数をカウントしてください。
SELECT
  CASE
    WHEN amount >= 10000 THEN '高'
    WHEN amount >= 5000 THEN '中'
    ELSE '低'
  END AS amount_category,
  COUNT(*) AS 件数
FROM (
  SELECT amount FROM store_sales
  UNION ALL
  SELECT amount FROM online_sales
) AS combined_sales
GROUP BY amount_category;

--4.  自己結合
--各従業員について、その従業員の名前と直属のマネージャーの名前を一覧表示してください。マネージャーがいない従業員の場合は、マネージャー名として「N/A」と表示してください。
SELECT 
    e1.employee_name AS employee_name,
    COALESCE(e2.employee_name, 'N/A') AS manager_name
FROM 
    employees e1
LEFT JOIN 
    employees e2 
ON 
    e1.manager_id = e2.employee_id;

--5.  WHERE句のサブクエリ
--「2022-01-01」以降に採用された従業員による売上をすべて見つけてください。
SELECT amount FROM store_sales
WHERE employee_id IN (
    SELECT employee_id
    FROM employees
    WHERE hire_date >= '2022-01-01' 
);

--6.  ウィンドウ関数：RANK
--商品カテゴリごとに、店舗とオンラインの売上を合算した総売上額に基づいて商品をランク付けしてください。各カテゴリで最も売上が高い商品のランクは1となるようにしてください。
SELECT category, product_name, total_sales, RANK() OVER (PARTITION BY category ORDER BY total_sales DESC) AS sales_rank
FROM (
    SELECT p.category, p.product_name, SUM(cs.amount) AS total_sales
    FROM(
        SELECT product_id, amount FROM store_sales
        UNION ALL
        SELECT product_id, amount FROM online_sales
    )AS cs
    JOIN products p ON cs.product_id = p.product_id
    GROUP BY p.category, p.product_name
) AS category_sales
ORDER BY category, sales_rank;

--7.  CTEと複数JOIN
--共通テーブル式（CTE）を使い、店舗売上とオンライン売上を1つのテーブルとして合算してください。その後、この合算テーブルを用いて都道府県ごとの総売上額を集計してください。
WITH all_sales AS (
    SELECT s.prefecture, ss.amount
    FROM store_sales ss
    JOIN stores s ON ss.store_id = s.store_id
    UNION ALL
    SELECT c.prefecture, os.amount
    FROM online_sales os
    JOIN customers c ON os.customer_id = c.customer_id
) 
SELECT prefecture, SUM(amount) AS total_sales
FROM all_sales
GROUP BY prefecture;

--8  FROM句のサブクエリ
--まず、顧客ごとの総売上額を含む派生テーブルを作成してください。次に、このテーブルを`customers`テーブルと結合して、総売上額が最も高い顧客の名前を見つけてください。
SELECT c.customer_name, s.total_sales
FROM (
    SELECT customer_id, SUM(total) AS total_sales
    FROM (
    SELECT customer_id, amount AS total
    FROM store_sales
    UNION ALL
    SELECT customer_id, amount AS total
    FROM online_sales
    ) AS all_sales
    GROUP BY customer_id
    ) AS s
JOIN customers c ON s.customer_id = c.customer_id
ORDER BY s.total_sales DESC
LIMIT 1;

--9.  ウィンドウ関数：SUM OVER
--各店舗の売上について、時間経過（`sale_date`に基づく）に伴う累積売上額を計算してください。結果には、各店舗の`sale_date`、その日の売上額、およびその日までの累積売上額を表示してください。
SELECT s.store_name, ds.sale_date, ds.daily_total,
       SUM(ds.daily_total) OVER (
           PARTITION BY ds.store_id
           ORDER BY ds.sale_date
       ) AS cumulative_sales
FROM (
    SELECT ss.store_id, ss.sale_date, SUM(ss.amount) AS daily_total
    FROM store_sales ss
    GROUP BY ss.store_id, ss.sale_date
) AS ds
JOIN stores s ON ds.store_id = s.store_id
ORDER BY s.store_name, ds.sale_date;

--10.  複数の機能を使った複雑なクエリ
--各商品カテゴリにおいて、男女（`gender`）のうち総購入額が高い方の性別と、その総額を求めてください。
WITH gender_sales AS (
    SELECT p.category, c.gender, ss.amount
    FROM store_sales ss
    JOIN products p ON ss.product_id = p.product_id
    JOIN customers c ON ss.customer_id = c.customer_id
    UNION ALL
    SELECT p.category, c.gender, os.amount
    FROM online_sales os
    JOIN products p ON os.product_id = p.product_id
    JOIN customers c ON os.customer_id = c.customer_id
),
category_gender_totals AS (
    SELECT category, gender, SUM(amount) AS total_amount
    FROM gender_sales
    GROUP BY category, gender
)
SELECT category, gender, total_amount
FROM (
    SELECT category, gender, total_amount,
         RANK() OVER (PARTITION BY category ORDER BY total_amount DESC) AS rank
    FROM category_gender_totals
) rank
WHERE rank = 1;