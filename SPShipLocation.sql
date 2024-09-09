--Stored Procedure for ShipLocation Table

CREATE PROCEDURE sp_ShipLocation(
    @LocationId INT,
    @LocationName VARCHAR(100),
    @PortName VARCHAR(255)
)
AS
BEGIN
INSERT INTO ShipLocation VALUES (@LocationId,@LocationName,@PortName)
END;

EXEC sp_ShipLocation
@LocationId = 10,
@LocationName = 'China',
@PortName = 'Port of Sahai'