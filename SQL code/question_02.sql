-- Q2.	Create the following tables. And Solve following queries by SQL

-- •	Deposit (actno,cname,bname,amount,adate)
-- •	Branch (bname,city)
-- •	Customers (cname, city)
-- •	Borrow(loanno,cname,bname, amount)
-- Add primary key and foreign key wherever applicable. Insert data into the above created tables.
-- 1.	Display names of depositors having amount greater than 4000.
-- 2.	Display account date of customers Anil
-- 3.	Display account no. and deposit amount of customers having account opened between dates 1-12-96 and 1-5-97
-- 4.	Find the average account balance at the Perryridge branch.
-- 5.	Find the names of all branches where the average account balance is more than $1,200.
-- 6.	Delete depositors having deposit less than 5000
-- 7.	Create a view on deposit table.




-- Create the Branch table
CREATE TABLE Branch (
    bname VARCHAR(255) PRIMARY KEY,
    city VARCHAR(255)
);

-- Create the Customers table
CREATE TABLE Customers (
    cname VARCHAR(255) PRIMARY KEY,
    city VARCHAR(255)
);

-- Create the Deposit table
CREATE TABLE Deposit (
    actno INT PRIMARY KEY,
    cname VARCHAR(255),
    bname VARCHAR(255),
    amount DECIMAL(10, 2),
    adate DATE,
    FOREIGN KEY (cname) REFERENCES Customers(cname),
    FOREIGN KEY (bname) REFERENCES Branch(bname)
);

-- Create the Borrow table
CREATE TABLE Borrow (
    loanno INT PRIMARY KEY,
    cname VARCHAR(255),
    bname VARCHAR(255),
    amount DECIMAL(10, 2),
    FOREIGN KEY (cname) REFERENCES Customers(cname),
    FOREIGN KEY (bname) REFERENCES Branch(bname)
);



-- Insert data into the Branch table
INSERT INTO Branch (bname, city) VALUES
    ('Branch1', 'City1'),
    ('Branch2', 'City2'),
    ('Branch3', 'City3');

-- Insert data into the Customers table
INSERT INTO Customers (cname, city) VALUES
    ('Customer1', 'City1'),
    ('Customer2', 'City2'),
    ('Customer3', 'City3');

-- Insert data into the Deposit table
INSERT INTO Deposit (actno, cname, bname, amount, adate) VALUES
    (101, 'Customer1', 'Branch1', 1000.00, '2023-01-01'),
    (102, 'Customer2', 'Branch2', 1500.50, '2023-01-02'),
    (103, 'Customer3', 'Branch3', 2000.75, '2023-01-03');

-- Insert data into the Borrow table
INSERT INTO Borrow (loanno, cname, bname, amount) VALUES
    (201, 'Customer1', 'Branch1', 500.00),
    (202, 'Customer2', 'Branch2', 750.25);

-- 1.	Display names of depositors having amount greater than 4000.

SELECT cname 
FROM Deposit
WHERE amount > 1000;

-- 2.	Display account date of customers Anil

SELECT adate
FROM Deposit
WHERE cname = "Customer1";

-- 3.	Display account no. and deposit amount of customers having account opened 
-- between dates 1-12-96 and 1-5-97

SELECT actno , amount
FROM Deposit
WHERE adate >= '2023-01-01' && adate <= '2023-01-03';

-- 4.	Find the average account balance at the Perryridge branch.
SELECT AVG(amount) AS average_account_balance
FROM Deposit
WHERE bname = 'Branch1';

-- 5.	Find the names of all branches where the average account balance is more than $1,200.

SELECT bname 
FROM Deposit
GROUP BY bname
HAVING AVG(amount) > 1200;

-- Delete depositors having a deposit less than 5000:

DELETE FROM Deposit
WHERE amount < 5000;

-- Create a view on the Deposit table:

CREATE VIEW DepositView AS
SELECT d.actno, d.cname, d.bname, d.amount, d.adate
FROM Deposit d;

-- Create an index on the Deposit table:

CREATE INDEX deposit_index ON Deposit(actno);

SELECT * 
FROM Deposit;


CREATE VIEW BorrowView AS
SELECT b.loanno, b.cname, b.bname, b.amount
FROM Borrow b;

SELECT * FROM BorrowView;
