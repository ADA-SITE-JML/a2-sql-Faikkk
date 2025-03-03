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
DELETE FROM laptops
WHERE laptop_id = 1;

-- 2. Inserting the non-existent laptop_id when adding a new record into the 'Employees' table
INSERT INTO employees (first_name, last_name, laptop_id)
VALUES ('Mammad','Mammadov',5);

