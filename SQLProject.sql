
CREATE TABLE ShipShip (
    ShipId INT PRIMARY KEY,
    CarrierId INT,
    DepatureLocationId INT,
    ArrivalLocationId INT,
    DepatureDate DATE,
    ArrivalDate DATE,
    Status VARCHAR(50),
    Duration AS DATEDIFF(day, DepatureDate, ArrivalDate), -- Computed column for duration

    CONSTRAINT fk_carrier FOREIGN KEY (CarrierId) REFERENCES ShipCarrier(CarrierId),
    CONSTRAINT fk_departure_location FOREIGN KEY (DepatureLocationId) REFERENCES ShipLocation(LocationId),
    CONSTRAINT fk_arrival_location FOREIGN KEY (ArrivalLocationId) REFERENCES ShipLocation(LocationId)
);

-- Insert Statement 
INSERT INTO ShipShip VALUES (1,1,1,2,'2024-07-25','2024-07-29','Delivered')
INSERT INTO ShipShip VALUES (2,1,2,3,'2024-07-31','2024-08-04','In-Transit')
INSERT INTO ShipShip VALUES (3,2,3,5,'2024-08-01','2024-08-05','Preparing To Sail')
INSERT INTO ShipShip VALUES (4,4,4,1,'2024-08-03','2024-08-10','Packing Process is Underway')
INSERT INTO ShipShip VALUES (5,5,5,2,'2024-07-29','2024-08-01','Unloading the Packages in Port')
INSERT INTO ShipShip VALUES (6,3,6,3,'2024-07-29','2024-08-01','Arrived the Detination Port')
INSERT INTO ShipShip VALUES (7,6,4,6,'2024-07-29','2024-08-07','In-Transit')
INSERT INTO ShipShip VALUES (8,8,8,1,'2024-07-29','2024-08-10','Sailing in Ocean')
INSERT INTO ShipShip VALUES (9,10,9,10,'2024-08-10','2024-08-15','Has Not Departed')
INSERT INTO ShipShip VALUES (10,9,7,9,'2024-07-29','2024-08-10','Sailing in Ocean')

SELECT ShipId,Status FROM ShipShip 
WHERE DepatureDate 	BETWEEN GETDATE()-10 And GETDATE()

-- Delete Statement
DELETE FROM ShipShip WHERE ShipId = 7

-- Read Statement
    SELECT * FROM ShipShip

-- Update Statement
UPDATE ShipShip Set CarrierId = 8 WHERE ShipId = 8

CREATE TABLE ShipCarrier (
    CarrierId INT PRIMARY KEY,
    CarrierName VARCHAR(100),
    ContactPerson VARCHAR(100)
);

ALTER TABLE ShipCarrier
ADD CONSTRAINT UQ_ShipCarrier_CarrierName UNIQUE(CarrierName)

INSERT INTO ShipCarrier VALUES (1,'Oceanic Frighet','Sam')
INSERT INTO ShipCarrier VALUES (2,'Global Shipping Co.','Tom')
INSERT INTO ShipCarrier VALUES (3,'Maersk','Ben')
INSERT INTO ShipCarrier VALUES (4,'Cosco Shipping Line','Sara')
INSERT INTO ShipCarrier VALUES (5,'Evergreen','Tim')
INSERT INTO ShipCarrier VALUES (6,'Ocean Network Express','David')  
INSERT INTO ShipCarrier VALUES (7,'Euronav','Alias')
INSERT INTO ShipCarrier VALUES (8,'Castor Maritime','Jessica')
INSERT INTO ShipCarrier VALUES (9, 'ISIRL Group','SentiBee')
INSERT INTO ShipCarrier VALUES (10,'COSCO Group','Mark')

SELECT * FROM ShipCarrier

DELETE FROM ShipCarrier WHERE CarrierId = 10

CREATE TABLE ShipPackage (
    PackageId INT PRIMARY KEY,
    ShipId  INT,
    PackageType NVARCHAR(50),
    Description NVARCHAR(50),
    PackageWeight DECIMAL(10, 2),
    FOREIGN KEY (ShipId) REFERENCES ShipShip(ShipId)
);

INSERT INTO ShipPackage VALUES (1,1,'Crate','Machinery Parts',500.00)
INSERT INTO ShipPackage VALUES (2,2,'Container','Electronics',1200.00)
INSERT INTO ShipPackage VALUES (3,3,'Boxes','Medical Equipments',700.00)
INSERT INTO ShipPackage VALUES (4,3,'Container','Two Wheel Vechiles',2000.00)
INSERT INTO ShipPackage VALUES (5,4,'Container','Cars',4000.00)
INSERT INTO ShipPackage VALUES (6,4,'Plastic Boxes','Medicines',300.00)
INSERT INTO ShipPackage VALUES (7,5,'Container','Furniture',5200.00)
INSERT INTO ShipPackage VALUES (8,6,'Bubble Wrapper','Glass',800.00)
INSERT INTO ShipPackage VALUES (9,7,'Crate','Goods',2200.00)
INSERT INTO ShipPackage VALUES (10,8,'Boxes','Cloth Materials',3300.00)

SELECT * FROM ShipPackage

CREATE TABLE ShipLocation (
    LocationId INT PRIMARY KEY,
    LocationName VARCHAR(100),
    PortName VARCHAR(255),
);

ALTER TABLE ShipLocation
ADD CONSTRAINT UQ_ShipLocation_PortName UNIQUE(PortName)


INSERT INTO ShipLocation VALUES (1,'Singapore','Port of Singapore')
INSERT INTO ShipLocation VALUES (2,'China','Port of Shenzhen')
INSERT INTO ShipLocation VALUES (3,'South Korea','Port of Busan')
INSERT INTO ShipLocation VALUES (4,'UAE','Port of Jebel Ali')
INSERT INTO ShipLocation VALUES (5,'Netherlands','Port of Rotterdam')
INSERT INTO ShipLocation VALUES (6,'United Stated','Port of Los Angeles')
INSERT INTO ShipLocation VALUES (7,'India','Port of Mumbai')
INSERT INTO ShipLocation VALUES (8,'Malaysia','Port of Klang')
INSERT INTO ShipLocation VALUES (9,'Belgium','Port of Antwerp')
INSERT INTO ShipLocation VALUES (10,'Germany','Port of Hamburg')


SELECT LocationName FROM ShipLocation WHERE LocationName LIKE 'S%'

SELECT * FROM ShipLocation

CREATE TABLE ShipDistance(
    DistanceId INT PRIMARY KEY,
    DepartureLocationId INT,
    ArrivalLocationId INT,
    Distance DECIMAL(10, 2), -- Distance in kilometers or any unit
    FOREIGN KEY (DepartureLocationId) REFERENCES ShipLocation(LocationId),
    FOREIGN KEY (ArrivalLocationId) REFERENCES ShipLocation(LocationId)
)

INSERT INTO ShipDistance VALUES (1, 1, 2, 5300.00) 
INSERT INTO ShipDistance VALUES (2, 2, 3, 5000.00) 
INSERT INTO ShipDistance VALUES (3, 3, 5, 4000.00) 
INSERT INTO ShipDistance VALUES (4, 4, 1, 3000.00)
INSERT INTO ShipDistance VALUES (5, 5, 2, 3500.00) 
INSERT INTO ShipDistance VALUES (6, 6, 3, 4000.00) 
INSERT INTO ShipDistance VALUES (7, 4, 6, 4200.00) 
INSERT INTO ShipDistance VALUES (8, 8, 1, 5500.00) 
INSERT INTO ShipDistance VALUES (9, 9, 10, 7200.00) 
INSERT INTO ShipDistance VALUES (10, 7, 9, 8200.00) 


SELECT * FROM ShipDistance

SELECT Status,DepatureDate, CAST (DepatureDate as nvarchar) AS DepartureDateStr
FROM ShipShip

SELECT CONVERT(VARCHAR(20), ArrivalDate, 103) AS ArrivalDateStr
FROM ShipShip;


-- SUM Query to ADD the Weight of Package in one Ship
ALTER VIEW vwSumPackageWeight
AS
SELECT SUM(PackageWeight) AS TotalWeightShipped
FROM ShipPackage
GROUP BY ShipId AS ShipId

-- Executing View
SELECT * FROM vwSumPackageWeight

--AVG Query
SELECT AVG(PackageWeight) AS AverageWeight
FROM ShipPackage
GROUP BY ShipId

--COUNT Query
SELECT l.LocationName, COUNT(s.ShipId) AS TotalShipments
FROM ShipShip s
JOIN ShipLocation l ON s.DepatureLocationId = l.LocationId
GROUP BY l.LocationName;

    -- COUNT Status
    SELECT
        ss.Status,
        COUNT(ss.ShipId) AS ShipmentCount
    FROM ShipShip ss
    GROUP BY ss.Status;
    
 -- Creating LogTable for the Trigger.

CREATE TABLE LogTable
(
  Id int identity(1,1) primary key,
  LogData nvarchar(1000)
)


SELECT * FROM LogTable


-- ERROR HANDLING IN ShipShip Table
BEGIN TRY 
BEGIN TRAN
INSERT INTO ShipShip VALUES (7,6,8,1,'2024-07-29','2024-08-01','Arrived the Detination Port')
COMMIT TRAN
END TRY
BEGIN CATCH
  Rollback Transaction
  Select 
   ERROR_NUMBER() as ErrorNumber,
   ERROR_MESSAGE() as ErrorMessage,
   ERROR_STATE() as ErrorState,
   ERROR_SEVERITY() as ErrorSeverity,
   ERROR_LINE() as ErrorLine
    End Catch


SELECT MAX(PackageWeight) AS [Maximum Weight] FROM ShipPackage