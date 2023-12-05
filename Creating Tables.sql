-- CREATE TABLES 

-- Create employees table 
CREATE TABLE employees (
    employee_id INT PRIMARY KEY, -- a primary key is a unique identifier in a table, used to uniquely identify each row in that table
    first_name VARCHAR(50), -- 50 refers to the maximum length of the characters
    last_name VARCHAR(50),
    email VARCHAR(50),
    hire_date DATE,
    gender VARCHAR(1), -- "M"/"F" (male/female)
    salary INT,
    coffeeshop_id INT
);

-- Create shops table
CREATE TABLE shops (
    coffeeshop_id INT PRIMARY KEY,
    coffeeshop_name VARCHAR(50),
    city_id INT
);

-- Add foreign key to the employees table(I didn't add it before because the shops table had not been created yet
-- so you can't add a foreign key that links to the primary key of a table that hasnt been defined yet
ALTER TABLE employees
ADD FOREIGN KEY (coffeeshop_id) -- a foreign key is not a must and it can link to the primary key of another table
REFERENCES shops(coffeeshop_id)
ON DELETE SET NULL; -- so there won't be rows in the referencing table(employees) that aren't in the referenced(shops) table

-- Create locations table
CREATE TABLE locations (
    city_id INT PRIMARY KEY,
    city VARCHAR(50),
    country VARCHAR(50)   
);

-- Add foreign key to shops table
ALTER TABLE shops
ADD FOREIGN KEY (city_id)
REFERENCES locations(city_id)
ON DELETE SET NULL;

-- Create suppliers table
CREATE TABLE suppliers (
    coffeeshop_id INT,
    supplier_name VARCHAR(40),
    coffee_type VARCHAR(20),
    PRIMARY KEY (coffeeshop_id, supplier_name), -- composite key
    FOREIGN KEY (coffeeshop_id) REFERENCES shops(coffeeshop_id)
    ON DELETE CASCADE -- this means when a row in the referenced table is deleted, the corresponding rows in the referencing table
    -- are automatically deleted as well, cascading the delete operation
);

-- a composite key is made up of two columns and only together can they uniquely identify each row and this is shown in our suppliers 
-- table where we have two primary keys