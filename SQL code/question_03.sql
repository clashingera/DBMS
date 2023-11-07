-- Q3.	The following tables form part of a database held in a relational DBMS: Hotel (HotelNo, Name, City) HotelNo is the primary key
-- Room (RoomNo, HotelNo, Type, Price)
-- Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo) Guest (GuestNo, GuestName, GuestAddress)

-- Solve following queries by SQL
-- 1.	List full details of all hotels.
-- 2.	How many hotels are there?
-- 3.	List the price and type of all rooms at the Grosvenor Hotel.
-- 4.	List the number of rooms in each hotel
-- 5.	List all guests currently staying at the Grosvenor Hotel.
-- 6.	List all double or family rooms with a price below £40.00 per night, in ascending order of price.
-- 7.	How many different guests have made bookings for August?
-- 8.	What is the total income from bookings for the Grosvenor Hotel today?
-- 9.	What is the most commonly booked room type for each hotel in London?
-- 10.	Update the price of all rooms by 5%.


CREATE DATABASE Hotel;
USE Hotel;

-- Create the Hotel table
CREATE TABLE Hotel (
    HotelNo INT PRIMARY KEY,
    Name VARCHAR(255),
    City VARCHAR(255)
);

-- Create the Room table
CREATE TABLE Room (
    RoomNo INT PRIMARY KEY,
    HotelNo INT,
    Type VARCHAR(50),
    Price DECIMAL(10, 2),
    FOREIGN KEY (HotelNo) REFERENCES Hotel(HotelNo)
);

-- Create the Guest table
CREATE TABLE Guest (
    GuestNo INT PRIMARY KEY,
    GuestName VARCHAR(255),
    GuestAddress VARCHAR(255)
);

-- Create the Booking table
CREATE TABLE Booking (
    HotelNo INT,
    GuestNo INT,
    DateFrom DATE,
    DateTo DATE,
    RoomNo INT,
    FOREIGN KEY (HotelNo) REFERENCES Hotel(HotelNo),
    FOREIGN KEY (GuestNo) REFERENCES Guest(GuestNo),
    FOREIGN KEY (RoomNo) REFERENCES Room(RoomNo)
);


-- Insert data into the Hotel table
INSERT INTO Hotel (HotelNo, Name, City) VALUES
    (1, 'Hotel A', 'City X'),
    (2, 'Hotel B', 'City Y');

-- Insert data into the Room table
INSERT INTO Room (RoomNo, HotelNo, Type, Price) VALUES
    (101, 1, 'Single', 100.00),
    (102, 1, 'Double', 150.00),
    (201, 2, 'Single', 120.00);

-- Insert data into the Guest table
INSERT INTO Guest (GuestNo, GuestName, GuestAddress) VALUES
    (1001, 'John Smith', '123 Main St'),
    (1002, 'Jane Doe', '456 Elm St');

-- Insert data into the Booking table
INSERT INTO Booking (HotelNo, GuestNo, DateFrom, DateTo, RoomNo) VALUES
    (1, 1001, '2023-01-15', '2023-01-20', 101),
    (2, 1002, '2023-02-10', '2023-02-15', 201);



-- Retrieve room information for a specific hotel:
SELECT * FROM Room WHERE HotelNo = 1;


-- Find bookings made by a specific guest:
SELECT * FROM Booking WHERE GuestNo = 1001;


-- Get the total price of a booking:
SELECT Room.Price
FROM Booking
JOIN Room ON Booking.RoomNo = Room.RoomNo
WHERE Booking.GuestNo = 1001;




-- 1.	List full details of all hotels.
SELECT * FROM Hotel;


-- 2.	How many hotels are there?
SELECT COUNT(*) AS total_hotels FROM Hotel;


-- 3.	List the price and type of all rooms at the Grosvenor Hotel.
SELECT Room.Price, Room.Type
FROM Room
WHERE Room.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Hotel A');
-- OR
SELECT Room.Price , Room.Type
FROM Room
JOIN Hotel ON Hotel.HotelNo = Room.HotelNo
WHERE Hotel.Name = "Hotel A";


-- 4.	List the number of rooms in each hotel
SELECT Hotel.Name, COUNT(Room.RoomNo) AS total_rooms
FROM Hotel
LEFT JOIN Room ON Hotel.HotelNo = Room.HotelNo
GROUP BY Hotel.Name;
-- OR
SELECT HotelNo, COUNT(RoomNo)
FROM Room
GROUP BY HotelNo;

-- 5.	List all guests "currently" staying at the Hotel A.
SELECT Guest.GuestName
FROM Guest
INNER JOIN Booking ON Guest.GuestNo = Booking.GuestNo
WHERE Booking.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Hotel A')
  AND DateFrom <= CURDATE() AND DateTo >= CURDATE();


-- 6.	List all double or family rooms with a price below £40.00 per night, in ascending order of price.
SELECT Room.RoomNo, Room.Type, Room.Price
FROM Room
WHERE Room.Type IN ('Double', 'Family') AND Room.Price < 40.00
ORDER BY Room.Price ASC;


-- 7.	How many different guests have made bookings for August?
SELECT COUNT(DISTINCT Booking.GuestNo) AS unique_guests
FROM Booking
WHERE DateFrom >= '2023-08-01' AND DateTo <= '2023-08-31';


-- 8.	What is the total income from bookings for the Grosvenor Hotel today?
SELECT SUM(Room.Price) AS total_income
FROM Room
JOIN Booking ON Room.RoomNo = Booking.RoomNo
WHERE Booking.HotelNo = (SELECT HotelNo FROM Hotel WHERE Name = 'Grosvenor Hotel')
  AND DateFrom <= CURDATE() AND DateTo >= CURDATE();


-- 9.	What is the most commonly booked room type for each hotel in London?
SELECT Hotel.Name, Room.Type, COUNT(Room.Type) AS room_count
FROM Hotel
JOIN Room ON Hotel.HotelNo = Room.HotelNo
WHERE Hotel.City = 'London'
GROUP BY Hotel.Name, Room.Type
HAVING COUNT(Room.Type) = (SELECT MAX(room_count) FROM (SELECT COUNT(Room.Type) AS room_count FROM Room GROUP BY Room.HotelNo, Room.Type) AS t);


-- 10.	Update the price of all rooms by 5%.
UPDATE Room
SET Price = Price * 1.05;
