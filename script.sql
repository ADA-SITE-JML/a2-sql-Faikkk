-- DROP TABLES
DROP TABLE employees CASCADE;
DROP TABLE laptops;
DROP TABLE cars;

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

