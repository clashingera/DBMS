-- Q1.	Create a db called company consist of the following tables. 1.Emp (eno,ename, 
-- job,hiredate,salary,commission,deptno,) 2.dept(deptno,deptname,location)
-- eno is primary key in emp deptno is primary key in dept Solve Queries by SQL

-- 1.	List the maximum salary paid to salesman
-- 2.	List name of emp whose name start with ‘I’
-- 3.	List details of emp who have joined before ’30-sept-81’
-- 4.	List the emp details in the descending order of their basic salary
-- 5.	List of no. of emp & avg salary for emp in the dept no ‘20’
-- 6.	List the avg salary, minimum salary of the emp hiredatewise for dept no ‘10’.
-- 7.	List emp name and its department
-- 8.	List total salary paid to each department
-- 9.	List details of employee working in ‘Dev’ department
-- 10.	Update salary of all employees in deptno 10 by 5 %.


CREATE DATABASE company;
USE company;

CREATE TABLE Emp (
    eno INT PRIMARY KEY,
    ename VARCHAR(255),
    job VARCHAR(255),
    hiredate DATE,
    salary DECIMAL(10, 2),
    commission DECIMAL(10, 2),
    deptno INT
);

CREATE TABLE Dept (
    deptno INT PRIMARY KEY,
    deptname VARCHAR(255),
    location VARCHAR(255)
);

-- Insert random values into the "Dept" table
INSERT INTO Dept (deptno, deptname, location)
VALUES (10, 'HR', 'New York');
INSERT INTO Dept (deptno, deptname, location)
VALUES (20, 'IT', 'San Francisco');
INSERT INTO Dept (deptno, deptname, location)
VALUES (30, 'Sales', 'Los Angeles');
INSERT INTO Dept (deptno, deptname, location)
VALUES (40, 'Marketing', 'Chicago');
INSERT INTO Dept (deptno, deptname, location)
VALUES (50, 'Finance', 'Houston');

-- Insert random values into the "Emp" table
INSERT INTO Emp (eno, ename, job, hiredate, salary, commission, deptno)
VALUES (1, 'John Doe', 'Manager', '2023-01-15', 60000, NULL, 10);
INSERT INTO Emp (eno, ename, job, hiredate, salary, commission, deptno)
VALUES (2, 'Jane Smith', 'Developer', '2023-02-20', 55000, NULL, 20);
INSERT INTO Emp (eno, ename, job, hiredate, salary, commission, deptno)
VALUES (3, 'Mike Johnson', 'Salesman', '2023-03-10', 45000, 2000, 30);
INSERT INTO Emp (eno, ename, job, hiredate, salary, commission, deptno)
VALUES (4, 'Emily Brown', 'Marketing Specialist', '2023-04-05', 48000, NULL, 40);
INSERT INTO Emp (eno, ename, job, hiredate, salary, commission, deptno)
VALUES (5, 'David Wilson', 'Accountant', '2023-05-15', 52000, NULL, 50);


SELECT * FROM Dept;

-- List the maximum salary paid to salesman:
SELECT MAX(salary) AS max_salary
FROM Emp
WHERE job = 'SALESMAN';

-- List names of employees whose names start with 'I':
SELECT ename
FROM Emp
WHERE ename LIKE 'I%';


-- List details of employees who have joined before '30-Sept-81':
SELECT *
FROM Emp;
WHERE hiredate < '1981-09-30';

-- List employee details in descending order of their basic salary:

SELECT *
FROM Emp
ORDER BY salary DESC;


-- List the number of employees and the average salary for employees in department number '20':

SELECT deptno, COUNT(*) AS num_employees, AVG(salary) AS avg_salary
FROM Emp
WHERE deptno = 20
GROUP BY deptno;

-- List employee names and their department names:

SELECT E.ename, D.deptname
FROM Emp E
JOIN Dept D ON E.deptno = D.deptno;

-- List the total salary paid to each department:

SELECT D.deptname, SUM(E.salary) AS total_salary
FROM Emp E
JOIN Dept D ON E.deptno = D.deptno
GROUP BY D.deptname;

-- List details of employees working in the 'Dev' department:

SELECT *
FROM Emp
WHERE deptno = (SELECT deptno FROM Dept WHERE deptname = 'Dev');

-- Update the salary of all employees in department number 10 by 5%:

UPDATE Emp
SET salary = salary * 1.05
WHERE deptno = 10;




