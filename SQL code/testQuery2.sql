SELECT * FROM Booking;

create table o_rollcall(roll_no int, name varchar(20) ,address varchar(20));


create table n_rollcall(roll_no int, name varchar(20), address varchar(20));

insert into o_rollcall values(3,'atharva','titn');
insert into o_rollcall values(2,'aaglave','Surya');


delimiter //
create procedure p1(in r1 int)
begin
declare r2 int;
declare exit_loop boolean;
declare c1 cursor for
select roll_no from o_rollcall
where roll_no>r1;
declare continue handler for not found
set
exit_loop=true;
open c1;
e_loop:loop
fetch c1 into r2;
if not exists(select * from n_rollcall where roll_no =r2)
then
insert into n_rollcall select * from o_rollcall
where roll_no=r2;
end if;
if exit_loop then
close c1;
leave e_loop;
end if;
end loop e_loop;
end;
//

call p1(1);

select * from Sales;



-- Example 1: Using a Cursor to Calculate the Total Sales.
-- In this example, we'll create a cursor to calculate the total sales from a Sales table.



-- Create a Sales table
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    Amount DECIMAL(10, 2)
);

-- Insert sample sales data
INSERT INTO Sales (Amount) VALUES (100.00), (200.50), (150.25);

-- Create a stored procedure with a cursor
DELIMITER //
CREATE PROCEDURE CalculateTotalSales()
BEGIN
    DECLARE total DECIMAL(10, 2) DEFAULT 0.00;
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR
        SELECT Amount FROM Sales;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    FETCH cur INTO @sale_amount;

    WHILE NOT done DO
        SET total = total + @sale_amount;
        FETCH cur INTO @sale_amount;
    END WHILE;

    CLOSE cur;

    SELECT total AS TotalSales;
END;
//
-- DELIMITER ;

-- Call the stored procedure
CALL CalculateTotalSales();

drop TABLE Sales;









SELECT * FROM Employees;

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(255)
);

INSERT INTO Employees (EmployeeName) VALUES ('Alice'), ('Bob'), ('Charlie');

-- Create a Sales table
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    Amount DECIMAL(10, 2)
);

-- Insert sample sales data
INSERT INTO Sales (Amount) VALUES (100.00), (200.50), (150.25);

-- Create a stored procedure with a cursor
CREATE PROCEDURE CalculateTotalSales()
BEGIN
    DECLARE total DECIMAL(10, 2) DEFAULT 0.00;
    DECLARE done INT DEFAULT 0;
    DECLARE sale_amount DECIMAL(10, 2);

    DECLARE cur CURSOR FOR
        SELECT Amount FROM Sales;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    FETCH cur INTO sale_amount;

    WHILE NOT done DO
        SET total = total + sale_amount;
        FETCH cur INTO sale_amount;
    END WHILE;

    CLOSE cur;

    SELECT total AS TotalSales;
END;

CALL CalculateTotalSales();

