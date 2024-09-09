--Stored Procedure for ShipPackage Table

CREATE PROCEDURE sp_ShipPackage(
    @PackageId INT,
    @ShipId  INT,
    @PackageType NVARCHAR(50),
    @Description NVARCHAR(50),
    @PackageWeight DECIMAL(10, 2)
)
AS
BEGIN
INSERT INTO ShipPackage VALUES (@PackageId,@ShipId,@PackageType,@Description,@PackageWeight)
END;

EXEC sp_ShipPackage
@PackageId = 10,
@ShipId = 3,
@PackageType = 'Bubble Wrapper',
@Description = 'Glass Products',
@PackageWeight = 500.00;
