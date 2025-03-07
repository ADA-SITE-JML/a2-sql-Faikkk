DROP TABLE employees CASCADE;
DROP TABLE laptops;
DROP TABLE cars;

-- TASK 1
CREATE TABLE laptops(
laptop_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
make VARCHAR(30),
model VARCHAR(60)
);

CREATE TABLE employees(
employee_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
laptop_id INTEGER REFERENCES laptops(laptop_id)
);

INSERT INTO laptops(make,model)
VALUES
	('Apple','Macbook Pro 14.2"'),
	('Asus','ROG Zephyrus G14'),
	('Lenovo','Thinkpad T14s Gen 5');

INSERT INTO employees(first_name, last_name,laptop_id)
VALUES
	('Ali','Aliyev',1),
	('Suleyman','Baghirov',2),
	('Nail','Huseynov',2),
	('Araz','Mammadov',3);

SELECT *
FROM laptops;

SELECT *
FROM employees;

-- CASE 1
-- DELETE
-- FROM laptops
-- WHERE laptop_id=1;

-- CASE 2
-- INSERT INTO employees (first_name,last_name,laptop_id)
-- VALUES
-- 		('Araz','Huseynov',5);

-- TASK 2
ALTER TABLE laptops
ADD COLUMN model_year VARCHAR(4);

UPDATE laptops
SET model_year = 2022
WHERE laptop_id = 1;

UPDATE laptops
SET model_year = 2023
WHERE laptop_id = 2;

UPDATE laptops
SET model_year = 2024
WHERE laptop_id = 3;

SELECT *
FROM laptops;

ALTER TABLE laptops
ALTER COLUMN model_year TYPE INTEGER USING(model_year::integer);

-- TASK 3
CREATE TABLE cars(
car_id INTEGER NOT NULL UNIQUE,
make VARCHAR(30) NOT NULL,
model_year INTEGER CHECK (model_year>2015),
model VARCHAR(30)
);

INSERT INTO cars
VALUES (1,'BMW',2023,'M5');

SELECT *
FROM cars;

INSERT INTO cars
VALUES (1,'BMW',2023,'M5');

-- INSERT INTO cars
-- VALUES (2,NULL,2023,'M5');

--INSERT INTO cars
--VALUES (3,'Lexus',2015,'ES300h');


