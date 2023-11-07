CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE
);

DROP TABLE employees;

-- Insert the first employee
INSERT INTO employees (employee_id, first_name, last_name, hire_date)
VALUES (1, 'John', 'Doe', '2023-01-15');

-- Insert the second employee
INSERT INTO employees (employee_id, first_name, last_name, hire_date)
VALUES (2, 'Jane', 'Smith', '2023-02-20');

-- Insert the third employee
INSERT INTO employees (employee_id, first_name, last_name, hire_date)
VALUES (3, 'Mike', 'Johnson', '2023-03-10');

-- Insert the fourth employee
INSERT INTO employees (employee_id, first_name, last_name, hire_date)
VALUES (4, 'Emily', 'Brown', '2023-04-05');

-- Insert the fifth employee
INSERT INTO employees (employee_id, first_name, last_name, hire_date)
VALUES (5, 'David', 'Wilson', '2023-05-15');

SELECT * FROM employees;


CREATE DATABASE bank;
USE bank;

CREATE TABLE Emp (
    eno INT PRIMARY KEY,
    ename VARCHAR(255),
    job VARCHAR(255),
    hiredate DATE,
    salary DECIMAL(10, 2),
    commission DECIMAL(10, 2),
    deptno INT
);


