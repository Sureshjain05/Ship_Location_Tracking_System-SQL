--Stored Procedure for ShipCarrier Table

CREATE PROCEDURE sp_ShipCarrier(
    @CarrierId INT ,
    @CarrierName VARCHAR(100),
    @ContactPerson VARCHAR(100)
)
AS
BEGIN
INSERT INTO ShipCarrier VALUES (@CarrierId,@CarrierName,@ContactPerson)
END;

EXEC sp_ShipCarrier
@CarrierId = 10,
@CarrierName = 'DHL',
@ContactPerson = 'Valarie'