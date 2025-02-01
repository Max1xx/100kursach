CREATE DATABASE Turfirma;
USE Turfirma;
CREATE TABLE Clients (
    clientid INT PRIMARY KEY AUTO_INCREMENT,
    firstname NVARCHAR(50) NOT NULL,
    lastname NVARCHAR(50) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(15),
    passportdata NVARCHAR(50)
);

CREATE TABLE Managers (
    managerid INT PRIMARY KEY AUTO_INCREMENT,
    firstname NVARCHAR(50) NOT NULL,
    lastname NVARCHAR(50) NOT NULL,
    email NVARCHAR(100),
    phone NVARCHAR(15)
);

CREATE TABLE Tours (
    tourid INT PRIMARY KEY AUTO_INCREMENT,
    tourname NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
    managerid INT,
    tourdata DATE,
    FOREIGN KEY (managerid) REFERENCES Managers(managerid)
);

CREATE TABLE Services (
    serviceid INT PRIMARY KEY AUTO_INCREMENT,
    servicename NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Sales (
    saleid INT PRIMARY KEY AUTO_INCREMENT,
    clientid INT,
    tourid INT,
    serviceid INT,
    saledate DATE,
    FOREIGN KEY (clientid) REFERENCES Clients(clientid),
    FOREIGN KEY (tourid) REFERENCES Tours(tourid),
    FOREIGN KEY (serviceid) REFERENCES Services(serviceid)
);

INSERT INTO Clients (firstname, lastname, email, phone, passportdata) VALUES
('Иван', 'Иванов', 'ivan.ivanov@example.com', '1234567890', '1234 567890'),
('Мария', 'Петрова', 'maria.petrov@example.com', '0987654321', '9876 543210'),
('Светлана', 'Сидорова', 'svetlana.sidorova@example.com', '1122334455', '4567 890123');
select * from Clients;

INSERT INTO Managers (firstname, lastname, email, phone) VALUES
('Алексей', 'Смирнов', 'alexey.smirnov@example.com', '3216549870'),
('Екатерина', 'Федорова', 'ekaterina.fedorova@example.com', '5678901234'),
('Дмитрий', 'Кузнецов', 'dmitry.kuznetsov@example.com', '2345678901');
select * from Managers;

INSERT INTO Tours (tourname, description, price, managerid, tourdata) VALUES
('Экскурсия по Москве', 'Увлекательная экскурсия по главным достопримечательностям столицы.', 5000.00, 1, '2023-11-01'),
('Поездка на Байкал', 'Невероятно красивый маршрут вокруг озера Байкал.', 15000.00, 2, '2023-12-15'),
('Путешествие в Санкт-Петербург', 'Культурная программа по самым известным музеям города.', 8000.00, 3, '2024-01-20');
select * from Tours;

INSERT INTO Services (servicename, description, price) VALUES
('Транспорт', 'Транспортные услуги по городу.', 1200.00),
('Гид', 'Услуга гида для экскурсии.', 3000.00),
('Питание', 'Пакет услуг по питанию.', 1500.00);
select * from Services;

INSERT INTO Sales (clientid, tourid, serviceid, saledate) VALUES
(1, 1, 1, '2023-11-01'),
(2, 2, 2, '2023-12-15'),
(3, 3, 3, '2024-01-20');
select * from Sales;

SELECT serviceid, servicename, description, price 
FROM Services;

SELECT SUM(s.price) AS total_cost 
FROM Sales sa 
JOIN Services s ON sa.serviceid = s.serviceid 
WHERE sa.clientid = 2; 

SELECT SUM(t.price + s.price) AS total_sales, t.tourname 
FROM Sales sa 
JOIN Tours t ON sa.tourid = t.tourid 
JOIN Services s ON sa.serviceid = s.serviceid 
WHERE sa.saledate BETWEEN '2023-01-01' AND '2023-12-31' 
GROUP BY t.tourname;

SELECT clientid, firstname, lastname, email, phone, passportdata 
FROM Clients;

SELECT m.managerid, m.firstname, m.lastname, SUM(s.price) AS total_services 
FROM Sales sa 
JOIN Tours t ON sa.tourid = t.tourid 
JOIN Managers m ON t.managerid = m.managerid 
JOIN Services s ON sa.serviceid = s.serviceid 
GROUP BY m.managerid, m.firstname, m.lastname;

SELECT c.clientid, c.firstname, c.lastname, c.email, c.phone 
FROM Sales sa 
JOIN Clients c ON sa.clientid = c.clientid 
WHERE sa.tourid = 1; 

SELECT c.firstname, c.lastname, t.tourname, s.servicename, s.price 
FROM Sales sa 
JOIN Clients c ON sa.clientid = c.clientid 
JOIN Tours t ON sa.tourid = t.tourid 
JOIN Services s ON sa.serviceid = s.serviceid 
WHERE c.clientid = 1 AND t.tourid = 1; 

SELECT DISTINCT c.clientid, c.firstname, c.lastname, c.email, c.phone 
FROM Sales sa 
JOIN Clients c ON sa.clientid = c.clientid 
WHERE sa.serviceid = 1; 

SELECT DISTINCT c.clientid, c.firstname, c.lastname, c.email, c.phone 
FROM Sales sa 
JOIN Clients c ON sa.clientid = c.clientid 
JOIN Tours t ON sa.tourid = t.tourid 
WHERE t.managerid = 2 AND sa.saledate BETWEEN '2023-01-01' AND '2023-12-31'; 

 

