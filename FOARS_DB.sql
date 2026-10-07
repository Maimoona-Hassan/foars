CREATE TABLE AIRLINE(
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_name VARCHAR(100) NOT NULL,
    iata_code VARCHAR(3) UNIQUE NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE AIRCRAFT_MODEL(
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50) NOT NULL,
    total_seating_capacity INT NOT NULL
);

CREATE TABLE AIRPORT(
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_name VARCHAR(100) NOT NULL,
    airport_code VARCHAR(3) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE PASSENGER(
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    passport_number VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE AIRCRAFT(
    aircraft_id INT PRIMARY KEY AUTO_INCREMENT,
    tail_number VARCHAR(20) UNIQUE NOT NULL,
    airline_id INT NOT NULL,
    model_id INT NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES AIRLINE (airline_id),
     FOREIGN KEY (model_id) REFERENCES AIRCRAFT_MODEL (model_id)
);

CREATE TABLE CREW_MEMBER(
    crew_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(20) NOT NULL,
    airline_id INT NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES AIRLINE(airline_id)
);


CREATE TABLE FLIGHT_ROUTE (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    distance_miles INT NOT NULL,
    origin_airport_id INT NOT NULL,
    destination_airport_id INT NOT NULL,
    FOREIGN KEY (origin_airport_id) REFERENCES AIRPORT(airport_id),
    FOREIGN KEY (destination_airport_id) REFERENCES AIRPORT(airport_id)
);

CREATE TABLE SCHEDULED_FLIGHT (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    economy_price DECIMAL(10, 2) NOT NULL,
    business_price DECIMAL(10, 2) NOT NULL,
    aircraft_id INT NOT NULL,
    route_id INT NOT NULL,
    FOREIGN KEY (aircraft_id) REFERENCES AIRCRAFT(aircraft_id),
    FOREIGN KEY (route_id) REFERENCES FLIGHT_ROUTE(route_id)
);

CREATE TABLE BOOKING(
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_reference VARCHAR(10) UNIQUE NOT NULL,
    booking_date DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    FOREIGN KEY(passenger_id) REFERENCES PASSENGER(passenger_id),
    FOREIGN KEY(flight_id) REFERENCES SCHEDULED_FLIGHT(flight_id)
);

CREATE TABLE TICKET(
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    seat_number VARCHAR(20) NOT NULL,
    class_type VARCHAR(20) NOT NULL,
    booking_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id)
);

CREATE TABLE BAGGAGE(
    baggage_id INT PRIMARY KEY AUTO_INCREMENT,
    weight_kg DECIMAL (5, 2) NOT NULL,
    baggage_type VARCHAR(30) NOT NULL,
    booking_id INT NOT NULL,
    FOREIGN KEY(booking_id) REFERENCES BOOKING(booking_id)
);

TRUNCATE TABLE BAGGAGE;
TRUNCATE TABLE TICKET;
TRUNCATE TABLE BOOKING;
TRUNCATE TABLE SCHEDULED_FLIGHT;
TRUNCATE TABLE FLIGHT_ROUTE;
TRUNCATE TABLE CREW_MEMBER;
TRUNCATE TABLE AIRCRAFT;
TRUNCATE TABLE PASSENGER;
TRUNCATE TABLE AIRPORT;
TRUNCATE TABLE AIRCRAFT_MODEL;
TRUNCATE TABLE AIRLINE; 



-- Disable foreign key checks to ensure clean execution
SET FOREIGN_KEY_CHECKS = 0;

-- 1. AIRPORT
INSERT INTO AIRPORT (airport_id, airport_name, airport_code, city, country) VALUES
(1, 'John F. Kennedy International Airport', 'JFK', 'New York', 'USA'),
(2, 'Los Angeles International Airport', 'LAX', 'Los Angeles', 'USA'),
(3, 'London Heathrow Airport', 'LHR', 'London', 'United Kingdom'),
(4, 'Dubai International Airport', 'DXB', 'Dubai', 'UAE'),
(5, 'Charles de Gaulle Airport', 'CDG', 'Paris', 'France'),
(6, 'Tokyo Haneda Airport', 'HND', 'Tokyo', 'Japan'),
(7, 'Singapore Changi Airport', 'SIN', 'Singapore', 'Singapore'),
(8, 'Frankfurt Airport', 'FRA', 'Frankfurt', 'Germany'),
(9, 'O''Hare International Airport', 'ORD', 'Chicago', 'USA'),
(10, 'Jinnah International Airport', 'KHI', 'Karachi', 'Pakistan');

-- 2. AIRLINE
INSERT INTO AIRLINE (airline_id, airline_name, iata_code, country) VALUES
(1, 'American Airlines', 'AA', 'USA'),
(2, 'Delta Air Lines', 'DL', 'USA'),
(3, 'United Airlines', 'UA', 'USA'),
(4, 'Emirates', 'EK', 'UAE'),
(5, 'British Airways', 'BA', 'United Kingdom'),
(6, 'Lufthansa', 'LH', 'Germany'),
(7, 'Qatar Airways', 'QR', 'Qatar'),
(8, 'Singapore Airlines', 'SQ', 'Singapore'),
(9, 'Air France', 'AF', 'France'),
(10, 'Pakistan International Airlines', 'PK', 'Pakistan');

-- 3. AIRCRAFT_MODEL
INSERT INTO AIRCRAFT_MODEL (model_id, model_name, manufacturer, total_seating_capacity) VALUES
(1, '737-800', 'Boeing', 180),
(2, '777-300ER', 'Boeing', 396),
(3, '787-9 Dreamliner', 'Boeing', 290),
(4, 'A320neo', 'Airbus', 180),
(5, 'A350-900', 'Airbus', 325),
(6, 'A380-800', 'Airbus', 525),
(7, '737 MAX 8', 'Boeing', 178),
(8, 'A330-300', 'Airbus', 277),
(9, 'E190', 'Embraer', 100),
(10, 'CRJ-900', 'Bombardier', 90);

-- 4. AIRCRAFT
INSERT INTO AIRCRAFT (aircraft_id, tail_number, airline_id, model_id) VALUES
(1, 'N101AA', 1, 1),
(2, 'N202DL', 2, 2),
(3, 'N303UA', 3, 3),
(4, 'A6-EKA', 4, 6),
(5, 'G-XWBA', 5, 5),
(6, 'D-AIXA', 6, 4),
(7, 'A7-BCA', 7, 3),
(8, '9V-SMA', 8, 5),
(9, 'F-HTYA', 9, 4),
(10, 'AP-BGY', 10, 2);

-- 5. FLIGHT_ROUTE
INSERT INTO FLIGHT_ROUTE (route_id, distance_miles, origin_airport_id, destination_airport_id) VALUES
(1, 2475, 1, 2), -- JFK -> LAX
(2, 3451, 1, 3), -- JFK -> LHR
(3, 3400, 4, 3), -- DXB -> LHR
(4, 3629, 4, 7), -- DXB -> SIN
(5, 3625, 5, 1), -- CDG -> JFK
(6, 3850, 8, 1), -- FRA -> JFK
(7, 5940, 3, 6), -- LHR -> HND
(8, 8770, 7, 2), -- SIN -> LAX
(9, 740, 10, 4), -- KHI -> DXB
(10, 1745, 9, 2); -- ORD -> LAX

-- 6. SCHEDULED_FLIGHT
INSERT INTO SCHEDULED_FLIGHT (flight_id, departure_time, arrival_time, status, economy_price, business_price, aircraft_id, route_id) VALUES
(1, '2026-10-10 08:00:00', '2026-10-10 11:30:00', 'Scheduled', 250.00, 750.00, 1, 1),
(2, '2026-10-10 18:30:00', '2026-10-11 06:30:00', 'Scheduled', 450.00, 1200.00, 2, 2),
(3, '2026-10-11 07:45:00', '2026-10-11 12:15:00', 'Scheduled', 500.00, 1500.00, 4, 3),
(4, '2026-10-11 03:00:00', '2026-10-11 14:30:00', 'Delayed', 400.00, 1100.00, 7, 4),
(5, '2026-10-12 10:00:00', '2026-10-12 12:30:00', 'Scheduled', 480.00, 1350.00, 9, 5),
(6, '2026-10-12 11:00:00', '2026-10-12 13:45:00', 'Scheduled', 520.00, 1400.00, 6, 6),
(7, '2026-10-13 15:45:00', '2026-10-14 11:30:00', 'Scheduled', 800.00, 2200.00, 5, 7),
(8, '2026-10-13 23:45:00', '2026-10-14 21:15:00', 'Scheduled', 950.00, 2800.00, 8, 8),
(9, '2026-10-14 02:00:00', '2026-10-14 03:30:00', 'Boarding', 180.00, 500.00, 10, 9),
(10, '2026-10-14 14:00:00', '2026-10-14 16:30:00', 'Scheduled', 210.00, 650.00, 3, 10);

-- 7. CREW_MEMBER
INSERT INTO CREW_MEMBER (crew_id, name, role, airline_id) VALUES
(1, 'David Clark', 'Captain', 1),
(2, 'Sarah Lewis', 'First Officer', 1),
(3, 'Mark Robinson', 'Captain', 2),
(4, 'Emily Walker', 'Flight Attendant', 2),
(5, 'Tariq Al-Hassan', 'Captain', 4),
(6, 'Elena Rostova', 'Purser', 4),
(7, 'James Smith', 'Captain', 5),
(8, 'Hans Mueller', 'First Officer', 6),
(9, 'Wei Zhang', 'Captain', 8),
(10, 'Usman Ali', 'Captain', 10);

-- 8. PASSENGER
INSERT INTO PASSENGER (passenger_id, first_name, last_name, email, phone_number, passport_number) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '+12025550101', 'A12345678'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '+12025550102', 'B98765432'),
(3, 'Ali', 'Khan', 'ali.khan@example.com', '+923005550103', 'PK9012345'),
(4, 'Emma', 'Watson', 'emma.w@example.com', '+442079460104', 'C34567890'),
(5, 'Carlos', 'Silva', 'carlos.s@example.com', '+34912345678', 'D45678901'),
(6, 'Yuki', 'Tanaka', 'yuki.t@example.com', '+81312345678', 'E56789012'),
(7, 'Ahmed', 'Al-Mansoor', 'ahmed.m@example.com', '+971501234567', 'F67890123'),
(8, 'Sophie', 'Dubois', 'sophie.d@example.com', '+33123456789', 'G78901234'),
(9, 'Liam', 'Miller', 'liam.m@example.com', '+12025550109', 'H89012345'),
(10, 'Maria', 'Garcia', 'maria.g@example.com', '+34987654321', 'I90123456');

-- 9. BOOKING
INSERT INTO BOOKING (booking_id, booking_reference, booking_date, total_amount, booking_status, passenger_id, flight_id) VALUES
(1, 'PNR001', '2026-10-01 10:00:00', 250.00, 'Confirmed', 1, 1),
(2, 'PNR002', '2026-10-01 11:30:00', 1200.00, 'Confirmed', 2, 2),
(3, 'PNR003', '2026-10-02 09:15:00', 180.00, 'Confirmed', 3, 9),
(4, 'PNR004', '2026-10-02 14:20:00', 500.00, 'Confirmed', 4, 3),
(5, 'PNR005', '2026-10-03 16:45:00', 480.00, 'Cancelled', 5, 5),
(6, 'PNR006', '2026-10-03 18:00:00', 2200.00, 'Confirmed', 6, 7),
(7, 'PNR007', '2026-10-04 08:10:00', 1100.00, 'Confirmed', 7, 4),
(8, 'PNR008', '2026-10-04 12:25:00', 520.00, 'Confirmed', 8, 6),
(9, 'PNR009', '2026-10-05 15:50:00', 210.00, 'Pending', 9, 10),
(10, 'PNR010', '2026-10-05 20:00:00', 2800.00, 'Confirmed', 10, 8);

-- 10. TICKET
INSERT INTO TICKET (seat_id, seat_number, class_type, booking_id) VALUES
(1, '12A', 'Economy', 1),
(2, '02B', 'Business', 2),
(3, '22C', 'Economy', 3),
(4, '14F', 'Economy', 4),
(5, '18D', 'Economy', 5),
(6, '01A', 'First', 6),
(7, '08C', 'Business', 7),
(8, '15A', 'Economy', 8),
(9, '30E', 'Economy', 9),
(10, '03K', 'Business', 10);

-- 11. BAGGAGE
INSERT INTO BAGGAGE (baggage_id, weight_kg, baggage_type, booking_id) VALUES
(1, 23.50, 'Checked', 1),
(2, 30.00, 'Checked', 2),
(3, 18.25, 'Checked', 3),
(4, 25.00, 'Checked', 4),
(5, 0.00, 'Carry-On', 5),
(6, 32.00, 'Checked', 6),
(7, 28.50, 'Checked', 7),
(8, 20.00, 'Checked', 8),
(9, 15.00, 'Checked', 9),
(10, 31.00, 'Checked', 10);

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

SELECT * FROM AIRLINE;
SELECT * FROM AIRCRAFT;
SELECT * FROM AIRCRAFT_MODEL;
SELECT * FROM CREW_MEMBER;
SELECT * FROM FLIGHT_ROUTE;
SELECT * FROM SCHEDULED_FLIGHT;
SELECT * FROM AIRPORT;
SELECT * FROM PASSENGER;
SELECT * FROM BOOKING;
SELECT * FROM TICKET;
SELECT * FROM BAGGAGE;