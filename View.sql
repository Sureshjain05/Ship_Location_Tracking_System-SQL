-- CREATING VIEW FOR THE JOIN

--Retrieve all the Details of Shipment and ShipLocation
CREATE VIEW vWShipPackageLocation
AS
SELECT 
    sp.PackageId,
    sp.ShipId,
    sp.PackageType,
    sp.Description,
    sp.PackageWeight,
    sl.LocationName,
    sl.PortName AS DeparturePortName
FROM ShipPackage sp
JOIN ShipShip ss ON sp.ShipId = ss.ShipId
JOIN ShipLocation sl ON ss.DepatureLocationId = sl.LocationId;

-- Executing View
SELECT * FROM vWShipPackageLocation

-- Retrieves all the Shipments Departure and Arrival Details
ALTER VIEW vWShipLocation
AS
SELECT 
    ss.ShipId,
    sl_departure.LocationName AS DepartureLocation,
    sl_departure.PortName AS DeparturePort,
    ss.DepatureDate,
    sl_arrival.LocationName AS ArrivalLocation,
    sl_arrival.PortName AS ArrivalPort,
    ss.ArrivalDate,
    ss.Status
FROM ShipShip ss
JOIN ShipLocation sl_departure ON ss.DepatureLocationId = sl_departure.LocationId
JOIN ShipLocation sl_arrival ON ss.ArrivalLocationId = sl_arrival.LocationId;

-- Executing View
SELECT * FROM vWShipLocation
SELECT * FROM vWShipPackageLocation