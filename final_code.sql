-- DROP TABLES
DROP TABLE employees CASCADE;
DROP TABLE laptops;
DROP TABLE cars;
DROP TABLE customers CASCADE;
DROP TABLE customers_orders;
DROP TABLE evs CASCADE;
DROP TABLE engines;
DROP TABLE join_table CASCADE;
DROP TABLE orders;

BEGIN TRANSACTION;
-- TASK 1
CREATE TABLE laptops(
laptop_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
make varchar(20),
model varchar(50)
);

CREATE TABLE employees(
employee_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
first_name varchar(30),
last_name varchar(30),
laptop_id INTEGER REFERENCES laptops(laptop_id)
);

INSERT INTO laptops (make, model)
VALUES
        ('Apple','MacBook Pro 14.2"'),
        ('Asus','ROG Zephyrus G14'),
        ('Lenovo','ThinkPad T14s Gen 5');

INSERT INTO employees (first_name, last_name, laptop_id)
VALUES
        ('Ali','Aliyev', 1),
        ('Suleyman','Bagirov',2),
        ('Nail','Huseynov',2),
        ('Araz','Mammadov',3);

SELECT *
FROM employees;

SELECT *
FROM laptops;

-- Referential integrity based on PK/FK
-- 1. Deleting the row from the 'Laptop' table referenced from the 'Employees' table

-- UNCOMMENT TO TEST
-- DELETE FROM laptops
-- WHERE laptop_id = 1;

-- 2. Inserting the non-existent laptop_id when adding a new record into the 'Employees' table

-- UNCOMMENT TO TEST
-- INSERT INTO employees (first_name, last_name, laptop_id)
-- VALUES ('Mammad','Mammadov',5);

-- TASK 2
ALTER TABLE laptops
ADD COLUMN model_year VARCHAR(30);

SELECT *
FROM laptops;

UPDATE laptops
SET model_year = 2022
WHERE laptop_id = 1;

UPDATE laptops
SET model_year = 2023
WHERE laptop_id = 2;

UPDATE laptops
SET model_year = 2024
WHERE laptop_id = 3;

ALTER TABLE laptops
ALTER COLUMN model_year TYPE INTEGER USING (model_year::integer);

-- TASK 3
CREATE TABLE cars (
        car_id INTEGER UNIQUE NOT NULL,
        make VARCHAR(20) NOT NULL,
        model_year INTEGER CHECK (model_year>2015),
        model VARCHAR(50)
);

INSERT INTO cars
VALUES (1,'BMW', 2022,'M5');

-- Uncomment to check the constraints
-- INSERT INTO cars
-- VALUES (1, 'Toyota', 2020, 'Camry')

-- INSERT INTO cars
-- VALUES (2, NULL, 2020, 'ES300h')

-- INSERT INTO cars
-- VALUES (3, 'Audi', 2010, 'RS5')

-- TASK 4
-- natural join
SELECT *
FROM employees
NATURAL JOIN laptops;

CREATE TABLE engines(
engine_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
spec VARCHAR(20),
drivetrain VARCHAR(10),
hp INTEGER,
torque_Nm INTEGER
);

CREATE TABLE evs(
ev_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
make VARCHAR(20),
model VARCHAR(20),
engine_id INTEGER REFERENCES engines(engine_id),
price INTEGER
);

INSERT INTO engines (spec,drivetrain, hp, torque_Nm)
VALUES
	('base','RWD',335,430),
	('luxury','RWD',394,590),
	('sport','AWD',593,794);

SELECT *
FROM engines;

INSERT INTO evs (make,model, engine_id, price)
VALUES
	('BMW','i5',1,50000),
	('Porsche','Taycan',3,70000),
	('Audi','A6 e-tron',1,52000),
	('Mercedes','EQB', NULL, 55000);

SELECT *
FROM evs;

-- inner join
SELECT *
FROM evs
INNER JOIN engines
	ON evs.engine_id = engines.engine_id;

-- left outer join
SELECT *
FROM evs
LEFT OUTER JOIN engines
	ON evs.engine_id = engines.engine_id;

-- right outer join
SELECT *
FROM evs
RIGHT OUTER JOIN engines
	ON evs.engine_id = engines.engine_id;

-- full outer join
SELECT *
FROM evs
FULL OUTER JOIN engines
	ON evs.engine_id = engines.engine_id;

-- TASK 5
-- regular view
CREATE VIEW current_prices AS
SELECT make, model, price
FROM evs;

SELECT *
FROM current_prices;

SELECT *
FROM evs;

UPDATE evs
SET price = 54000
WHERE make = 'BMW';

-- materialized view
CREATE MATERIALiZED VIEW evs_price_stat AS
SELECT AVG(price), MIN(price), MAX(price)
FROM evs;

SELECT *
FROM evs_price_stat;

UPDATE evs
SET price = CASE
	WHEN make = 'BMW' THEN 49000
	WHEN make = 'Audi' THEN 43000
	WHEN make = 'Porsche' THEN 75000
END
WHERE make in ('BMW', 'Audi', 'Porsche');

REFRESH MATERIALIZED VIEW evs_price_stat;

-- Task 6
CREATE TABLE customers_orders(
order_id INTEGER GENERATED ALWAYS AS IDENTITY,
price INTEGER,
category VARCHAR(40),
customer_id INTEGER,
first_name VARCHAR(40),
last_name VARCHAR(40),
email VARCHAR(40)
);

INSERT INTO customers_orders (price, category, customer_id, first_name, last_name, email)
VALUES
	(500, 'Electronics',1,'Ali','Aliyev','alialiyev@gmail.com'),
	(30.7, 'Sport and Outdoors',2,'Behruz','Aliyev','behruzaliyev@gmail.com'),
	(15.52, 'Home and Kitchen',3,'Leyli','Baghirova','leylibaghirova@gmail.com'),
	(37.2,'Health and Beauty',4,'Asmer','Khudiyeva','asmarkhudiyeva@gmail.com');

SELECT *
FROM customers_orders;

-- orders
CREATE TABLE orders AS
SELECT order_id, price, category
FROM customers_orders;

ALTER TABLE orders ADD CONSTRAINT order_id_pk PRIMARY KEY(order_id);

SELECT *
FROM orders;

SELECT *, price*0.8 AS discounted_price
FROM orders;

-- customers
CREATE TABLE customers(
customer_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
email VARCHAR(40)
);

INSERT INTO customers (first_name, last_name, email)
SELECT first_name, last_name, email
FROM customers_orders;

SELECT *
FROM customers;

-- join table
CREATE TABLE join_table (
customer_id INTEGER REFERENCES orders(order_id),
order_id INTEGER REFERENCES customers(customer_id),
PRIMARY KEY (customer_id, order_id)
);

INSERT INTO join_table
SELECT customer_id, order_id
FROM customers_orders;

SELECT *
FROM join_table;

COMMIT;
-- Task 7

SELECT *
FROM evs;

BEGIN TRANSACTION;

UPDATE evs
SET price = CASE
	WHEN make = 'BMW' THEN 4900
	WHEN make = 'Audi' THEN 4300
	WHEN make = 'Porsche' THEN 7500
END
WHERE make in ('BMW', 'Audi', 'Porsche');

ROLLBACK;

UPDATE evs
SET price = CASE
	WHEN make = 'BMW' THEN 51000
	WHEN make = 'Audi' THEN 45000
	WHEN make = 'Porsche' THEN 75000
END
WHERE make in ('BMW', 'Audi', 'Porsche');

COMMIT;
