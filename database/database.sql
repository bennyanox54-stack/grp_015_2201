CREATE DATABASE ticket_reservation;

USE ticket_reservation;
CREATE TABLE passengers (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100)
);

CREATE TABLE routes (
    route_id INT AUTO_INCREMENT PRIMARY KEY,
    transport_type ENUM('Air', 'Bus') NOT NULL,
    departure_location VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL
);

CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    transport_type ENUM('Air', 'Bus') NOT NULL,
    vehicle_name VARCHAR(100) NOT NULL,
    registration_number VARCHAR(50) UNIQUE NOT NULL,
    seat_capacity INT NOT NULL
);

CREATE TABLE trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    route_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    fare DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    trip_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Booked', 'Cancelled') DEFAULT 'Booked',
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id),
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id),
    UNIQUE (trip_id, seat_number)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);