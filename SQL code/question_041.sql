

CREATE DATABASE plSQL;
USE plSQL;


-- a)	Consider table Stud(Roll, Att,Status)

-- Write a PL/SQL block for following requirement and handle the exceptions. 
-- Roll no. of student will be entered by user. Attendance of roll no. 
-- entered by user will be checked in Stud table. If attendance is less than 75% then
-- display the message “Term not granted” and set the status in stud table as “D”.
-- Otherwise display message “Term granted” and set the status in stud table as “ND”

-- Create the Stud table in MySQL
CREATE TABLE Stud (
    Roll INT PRIMARY KEY,
    Att INT,
    Status VARCHAR(2)
);

-- Insert sample data in MySQL
INSERT INTO Stud (Roll, Att, Status) VALUES
    (1, 80, 'ND'),
    (2, 85, 'D'),
    (3, 90, 'ND');


-- Create a stored procedure in MySQL
CREATE PROCEDURE CheckAttendance(IN roll_number INT)
BEGIN
    DECLARE v_attendance INT;
    DECLARE done INT DEFAULT 0;

    -- Retrieve the student's attendance from the Stud table
    SELECT Att INTO v_attendance
    FROM Stud
    WHERE Roll = roll_number;

    -- Check attendance and update status
    IF v_attendance < 75 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Term not granted';
    ELSE
        UPDATE Stud
        SET Status = 'ND'
        WHERE Roll = roll_number;
    END IF;
END;

CALL CheckAttendance(1);

SELECT * FROM Stud;



-- b)	Write a PL/SQL block for following requirement using user defined exception
-- handling. The account_master table records the current balance for an account, 
-- which is updated whenever, any deposits or withdrawals takes place. 
-- If the withdrawal attempted is more than the current balance held in the account. 
-- The user defined exception is raised, displaying an appropriate message. 
-- Write a PL/SQL block for above requirement using user defined exception handling.

-- Create the account_master table
CREATE TABLE account_master (
    account_number NUMBER PRIMARY KEY,
    current_balance NUMBER(10, 2)
);

-- Insert sample data
INSERT INTO account_master (account_number, current_balance) VALUES
    (1, 1000.00),
    (2, 2500.50),
    (3, 500.00);





--------------- CURSOR --------------
-- b)	Organization has decided to increase the salary of employees by 10% 
-- of existing salary, who are having salary less than average salary of organization,
--  Whenever such salary updates takes place, a record for 
-- the same is maintained in the increment_salary table.

-- Create the employee table
CREATE TABLE employee (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    emp_salary NUMBER(10, 2)
);

-- Create the increment_salary table to track salary increments
CREATE TABLE increment_salary (
    increment_id NUMBER PRIMARY KEY,
    emp_id NUMBER,
    previous_salary NUMBER(10, 2),
    new_salary NUMBER(10, 2),
    increment_date DATE
);

-- Insert sample data into the employee table
INSERT INTO employee (emp_id, emp_name, emp_salary) VALUES
    (1, 'John', 50000.00),
    (2, 'Alice', 60000.00),
    (3, 'Bob', 45000.00),
    (4, 'Charlie', 55000.00);


-- PL/SQL block for updating employee salaries and maintaining records
DECLARE
    v_avg_salary NUMBER;
BEGIN
    -- Calculate the average salary of the organization
    SELECT AVG(emp_salary) INTO v_avg_salary
    FROM employee;

    -- Loop through employees and update their salary if it's less than the average
    FOR emp_rec IN (SELECT emp_id, emp_salary FROM employee WHERE emp_salary < v_avg_salary) LOOP
        -- Calculate the new salary with a 10% increment
        DECLARE
            v_new_salary NUMBER;
        BEGIN
            v_new_salary := emp_rec.emp_salary * 1.10;

            -- Update the employee's salary
            UPDATE employee
            SET emp_salary = v_new_salary
            WHERE emp_id = emp_rec.emp_id;

            -- Insert a record into the increment_salary table
            INSERT INTO increment_salary (emp_id, previous_salary, new_salary, increment_date)
            VALUES (emp_rec.emp_id, emp_rec.emp_salary, v_new_salary, SYSDATE);
        END;
    END LOOP;

    -- Commit the changes to the database
    COMMIT;
END;
