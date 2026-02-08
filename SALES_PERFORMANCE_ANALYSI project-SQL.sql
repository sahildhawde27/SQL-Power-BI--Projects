CREATE DATABASE SALES_PERFORMANCE_ANALYSIS01
USE SALES_PERFORMANCE_ANALYSIS01


-- ===========================
--   TABLE: customers
-- ===========================
CREATE TABLE customers (customer_id VARCHAR(10) PRIMARY KEY, customer_name VARCHAR(50), region VARCHAR(20))

INSERT INTO customers VALUES
('C001','Aditi Sharma','North'),
('C002','Rohan Verma','South'),
('C003','Vikram Patel','West'),
('C004','Neha Singh','East'),
('C005','Sanjay Kumar','North'),
('C006','Priya Nair','South'),
('C007','Sunil Mehra','West'),
('C008','Sneha Rao','East'),
('C009','Arjun Gupta','North'),
('C010','Kavita Das','South')


-- ===========================
--   TABLE: products
-- ===========================
CREATE TABLE products (product_id VARCHAR(10) PRIMARY KEY,product_name VARCHAR(50),category VARCHAR(20),price INT)

INSERT INTO products VALUES
('P001','Wireless Mouse','Electronics',899),
('P002','Laptop Bag','Accessories',1299),
('P003','Bluetooth Speaker','Electronics',2499),
('P004','Office Chair','Furniture',5999),
('P005','Desk Lamp','Furniture',1499),
('P006','Power Bank','Electronics',1999),
('P007','Water Bottle','Lifestyle',499),
('P008','Notebook','Stationery',99)


-- ===========================
--   TABLE: sales
-- ===========================
CREATE TABLE sales (sale_id VARCHAR(10) PRIMARY KEY, customer_id VARCHAR(10), product_id VARCHAR(10),sale_date DATE, quantity INT)

INSERT INTO sales VALUES
('S001','C001','P001','2023-01-05',1),
('S002','C002','P003','2023-01-10',2),
('S003','C003','P002','2023-01-13',1),
('S004','C004','P004','2023-02-02',1),
('S005','C005','P001','2023-02-07',3),
('S006','C001','P006','2023-02-09',1),
('S007','C006','P005','2023-02-18',1),
('S008','C007','P007','2023-03-03',2),
('S009','C008','P008','2023-03-05',5),
('S010','C009','P003','2023-03-11',1),
('S011','C010','P001','2023-03-15',2),
('S012','C002','P006','2023-04-02',1),
('S013','C003','P003','2023-04-06',1),
('S014','C004','P005','2023-04-12',2),
('S015','C005','P004','2023-05-03',1),
('S016','C006','P001','2023-05-09',1),
('S017','C007','P002','2023-05-21',1),
('S018','C008','P007','2023-05-30',3),
('S019','C009','P008','2023-06-04',6),
('S020','C010','P006','2023-06-09',1),
('S021','C001','P003','2023-06-15',1),
('S022','C002','P007','2023-07-01',3),
('S023','C003','P001','2023-07-05',1),
('S024','C004','P002','2023-07-14',2),
('S025','C005','P003','2023-08-02',2),
('S026','C006','P004','2023-08-07',1),
('S027','C007','P001','2023-08-15',2),
('S028','C008','P003','2023-09-04',1),
('S029','C009','P005','2023-09-11',1),
('S030','C010','P002','2023-09-19',3),
('S031','C001','P008','2023-10-01',4),
('S032','C002','P003','2023-10-05',1),
('S033','C003','P004','2023-10-11',1),
('S034','C004','P001','2023-10-19',2),
('S035','C005','P007','2023-10-29',1),
('S036','C006','P008','2023-11-04',3),
('S037','C007','P006','2023-11-11',1),
('S038','C008','P005','2023-11-20',1),
('S039','C009','P001','2023-12-02',2),
('S040','C010','P003','2023-12-08',1),
('S041','C001','P005','2023-12-12',1),
('S042','C002','P001','2023-12-21',1),
('S043','C003','P007','2023-12-28',2),
('S044','C004','P003','2023-12-29',1),
('S045','C005','P002','2023-12-30',1)


 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 SELECT * FROM customers
 SELECT * FROM products
 SELECT * FROM sales
 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

 --TASKS--

  --1) Customers with their sales details --
  SELECT 
  customers.customer_id,
  customers.customer_name,
  sales.sale_id,
  sales.sale_date,
  sales.quantity
  FROM	customers
  INNER JOIN sales ON customers.customer_id =sales.customer_id
  

  --2) Overall business revenue --
  SELECT SUM(products.price*SALES.quantity) AS TOTAL_REVENUE FROM SALES
  JOIN products on SALES.product_id = products.product_id


  --3) Revenue by Region --
  SELECT customers.region, sum(products.price*sales.quantity) AS REGION_REVENUE
  FROM sales
  JOIN customers ON sales.customer_id = customers.customer_id
  JOIN products	ON sales.product_id = products.product_id
  GROUP BY customers.region
  ORDER BY REGION_REVENUE DESC


  --4) Top 5 Best-Selling Products --
  SELECT TOP 5 
  sales.product_id,
  products.product_name,
  SUM (sales.quantity) AS TOP_UNITS_SOLD
  FROM sales
  JOIN products ON sales.product_id = products.product_id
  GROUP BY sales.product_id, products.product_name
  ORDER BY TOP_UNITS_SOLD DESC

  
  --5) Total Orders received --
  SELECT 
  COUNT(sale_id) AS total_orders
  FROM sales


  -- 6) All products, including those never sold --
  SELECT 
  products.product_name,
  products.category,
  sales.sale_id
  FROM sales
  RIGHT JOIN products ON sales.product_id = products.product_id


  -- 7) Highest Revenue Generating Product--
  SELECT TOP 1 products.product_name,
 SUM(products.price * sales.quantity) AS TOTAL_REVENUE
 FROM sales
 JOIN products ON sales.product_id = products.product_id
 GROUP BY products.product_name
 ORDER BY  TOTAL_REVENUE DESC


 -- 8) Average Order Value --
  SELECT 
    AVG(products.price * sales.quantity) AS AVG_ORDER_VALUE
   FROM sales
   JOIN products ON sales.product_id = products.product_id

 
 
 /* 1) CUSTOMERS WITH THEIR SALES DETAILS
    Shows how many customers are actively buying from the business.

    2) OVERALL BUSINESS REVENUE
    Shows the overall financial performance of the business.

    3) REVENUE BY REGION
    Identifies the highest and lowest performing regions.

	4) TOP 5 BEST-SELLING PRODUCTS
	Highlights products in highest demand.

	5) TOTAL ORDERS RECEIVED
	Indicates the total number of sales transactions.

	6) ALL PRODUCTS, INCLUDING THOSE NEVER SOLD
	Number of products that were sold at least once.

	7) HIGHEST REVENUE GENERATING PRODUCT
	Shows which categories bring the most value.

	8) AVERAGE ORDER VALUE
	shows the average amount of products sold*/ 


	






