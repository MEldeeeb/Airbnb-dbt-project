create or replace WAREHOUSE finance_wh
with WAREHOUSE_SIZE = 'XSMALL'
AUTo_SUSPEND = 60
AUTO_RESUME = TRUE
INITIALLY_SUSPENDED = TRUE;



create or replace DATABASE finance_db;
create or replace schema raw;

----------------------------------------------------------- DWH Tables -----------------------------------------------------------
-- creating customers table
CREATE OR REPLACE TABLE raw.customers(
    id INT PRIMARY KEY,
    name varchar,
    email varchar,
    country varchar
);



-- creating orders table
CREATE OR REPLACE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount INT,
    status varchar
);



-- creating order_items table
CREATE OR REPLACE TABLE raw.order_items(
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price INT
);



-- creating products table
CREATE OR REPLACE TABLE products(
    id INT PRIMARY KEY,
    name varchar,
    category varchar,
    price INT  
);

----------------------------------------------------------- Staging Area -----------------------------------------------------------
-- creating finance_stage
create or replace stage finance_stage
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1);


-- loading data into customers table from staging area  
copy into raw.customers
from @FINANCE_STAGE/customers.csv
FILE_FORMAT = (Type = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER=1)


-- loading data into customers table from staging area  
copy into raw.orders
from @FINANCE_STAGE/orders.csv
FILE_FORMAT = (Type = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER=1)


-- loading data into customers table from staging area  
copy into raw.order_items
from @FINANCE_STAGE/order_items.csv
FILE_FORMAT = (Type = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER=1)



-- loading data into customers table from staging area  
copy into raw.products
from @FINANCE_STAGE/products.csv
FILE_FORMAT = (Type = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY='"' SKIP_HEADER=1)
------------------------------------------------------------------------------------------------------------------------------------
SELECT CURRENT_ACCOUNT();
-- NP83949

SELECT CURRENT_REGION();
-- AWS_EU_CENTRAL_2

SELECT CURRENT_USER();
-- MELDEEB17

------------------------------------------------------------------------------------------------------------------------------------
select * from customers;
select * from order_items;
select * from orders;
select * from products;

------------------------------------------------------------------------------------------------------------------------------------
drop view STG_CUSTOMERS ;
drop view STG_ORDERS ;
drop view STG_ORDER_ITEMS ;
drop view STG_PRODUCTS ;
drop table FCT_ORD_DAILY_REVENUE ;