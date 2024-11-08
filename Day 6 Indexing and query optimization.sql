use challenge;
-- Create the departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Insert data into departments table
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'IT'),
(4, 'Marketing');

SELECT * FROM departments;

-- Create the employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    join_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert data into employees table
INSERT INTO employees (employee_id, first_name, last_name, department_id, salary, join_date) VALUES
(1, 'John', 'Smith', 1, 70000, '2020-05-10'),
(2, 'Jane', 'Doe', 2, 75000, '2019-03-15'),
(3, 'Emily', 'Johnson', 1, 50000, '2021-07-22'),
(4, 'Michael', 'Brown', 3, 68000, '2018-08-12'),
(5, 'Sarah', 'Davis', 2, 54000, '2020-09-11'),
(6, 'Chris', 'Wilson', 4, 71000, '2017-11-19');

SELECT * FROM employees;

#Index on last_name for faster searching by last name:
CREATE INDEX idx_last_name ON employees(last_name);

#Composite Index on department_id and salary for filtering employees by department and salary:
CREATE INDEX idx_dept_salary ON employees(department_id, salary);

#Sample Queries to Optimize : Here are some sample queries you can use to test the effects of indexing.
#Query 1: Search by last_name
SELECT first_name, last_name, salary 
FROM employees 
WHERE last_name = 'Doe';

#Query 2: Filter by department_id and sort by salary
SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id = 2
ORDER BY salary DESC;

#Query 3: Join employees and departments
#This query retrieves the department name and joins it with employee data, which may benefit from indexing on department_id.
SELECT e.Employee_id, concat(e.first_name," ",e.last_name) as Name ,e.salary,d.department_name
FROM employees e JOIN departments d 
ON e.department_id = d.department_id
WHERE e.salary > 60000;

#5. Checking the Execution Plan
#You can check the execution plan of each query to see if the indexes are being used. In MySQL, for example: 
EXPLAIN SELECT first_name, last_name, salary FROM employees WHERE last_name = 'Doe';
