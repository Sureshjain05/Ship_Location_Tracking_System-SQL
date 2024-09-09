--Stored Procedure (Insert) for ShipShip Table
ALTER PROCEDURE sp_ShipShip(
    @ShipId INT,
    @CarrierId INT,
    @DepatureLocationId INT,
    @ArrivalLocationId INT,
    @DepatureDate DATE,
    @ArrivalDate DATE,
    @Status VARCHAR(50)
)
AS
BEGIN
IF EXISTS (SELECT 1 FROM ShipCarrier WHERE CarrierId = @CarrierId) AND
EXISTS (SELECT 1 FROM ShipLocation WHERE LocationId = @DepatureLocationId) AND
EXISTS (SELECT 1 FROM ShipLocation WHERE LocationId = @ArrivalLocationId)
BEGIN
INSERT INTO ShipShip VALUES (@ShipId, @CarrierId, @DepatureLocationId, @ArrivalLocationId, @DepatureDate,@ArrivalDate,@Status);
SELECT 'Ship added successfully.' AS Result;
END
ELSE
BEGIN
SELECT 'One or more of the specified IDs do not exist.' AS Result;
END;
END;

-- Executing Stored Procedure(Insert)
EXEC sp_ShipShip
@ShipId = 11,
@CarrierId =7,
@DepatureLocationId = 6,
@ArrivalLocationId = 10,
@DepatureDate = '2024-07-31',
@ArrivalDate = '2024-08-07',
@Status = 'In-Transit'




DELETE FROM ShipShip WHERE ShipId = 11


--Stored Procedure (Update) for ShipShip Table

CREATE PROCEDURE sp_UpdateShipShip
    @ShipId INT,
    @CarrierId INT,
    @DepatureLocationId INT,
    @ArrivalLocationId INT,
    @DepatureDate DATE,
    @ArrivalDate DATE,
    @Status VARCHAR(50)
AS
BEGIN
    UPDATE ShipShip
    SET CarrierId = @CarrierId,
        DepatureLocationId = @DepatureLocationId,
        ArrivalLocationId = @ArrivalLocationId,
        DepatureDate = @DepatureDate,
        ArrivalDate = @ArrivalDate,
        Status = @Status
    WHERE ShipId = @ShipId;
END;

-- Executing Stored Procedure(Update)
EXEC sp_UpdateShipShip
    @ShipId = 11,
    @CarrierId = 8,
    @DepatureLocationId = 1,
    @ArrivalLocationId = 10,
    @DepatureDate = '2024-07-03',
    @ArrivalDate = '2024-07-12',
    @Status = 'Delivered';



--Stored Procedure (Delete) for ShipShip Table

CREATE PROCEDURE sp_DeleteShipShip
    @ShipId INT
AS
BEGIN
    DELETE FROM ShipShip
    WHERE ShipId = @ShipId;
END;



-- Executing Stored Procedure(Delete)
EXEC sp_DeleteShipShip @ShipId = 11;

