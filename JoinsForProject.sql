--Retrieve the Carrier information along with Shipment Detail
SELECT 
    sc.CarrierName,
    ss.ShipId,
    ss.DepatureLocationId,
    ss.ArrivalLocationId,
    ss.DepatureDate,
    ss.ArrivalDate,
    ss.Status
FROM ShipCarrier sc
JOIN ShipShip ss ON sc.CarrierId = ss.CarrierId;

--Retrieve all the Details of Shipment and ShipLocation

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

-- Retrieves all the Shipments Departure and Arrival Details
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


-- Retrieves all the Location Name and Distance
SELECT 
    ss.ShipId,
    sl_departure.PortName AS DeparturePort,
    sl_arrival.PortName AS ArrivalPort,
    sd.Distance AS ShipTotalDistance,
    ss.Duration AS DurationInDays,
    ss.Status
FROM  ShipShip ss
JOIN ShipDistance sd ON ss.DepatureLocationId = sd.DepartureLocationId AND ss.ArrivalLocationId = sd.ArrivalLocationId
JOIN ShipLocation sl_departure ON ss.DepatureLocationId = sl_departure.LocationId
JOIN ShipLocation sl_arrival ON ss.ArrivalLocationId = sl_arrival.LocationId;