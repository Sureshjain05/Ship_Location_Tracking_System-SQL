-- CREATING FUNCTION FOR THE JOIN  

CREATE FUNCTION dbo.fn_GetShipsWithCarrier()
RETURNS TABLE
AS
RETURN
(
    SELECT 
    sc.CarrierName,
    ss.ShipId,
    ss.DepatureLocationId,
    ss.ArrivalLocationId,
    ss.DepatureDate,
    ss.ArrivalDate,
    ss.Status
FROM ShipCarrier sc
JOIN ShipShip ss ON sc.CarrierId = ss.CarrierId
);

-- Executing Function
SELECT * FROM dbo.fn_GetShipsWithCarrier()

-- Retrieves all the Location Name and Distance
CREATE FUNCTION dbo.fn_GetTotalDistance()
RETURNS TABLE
AS
RETURN
(
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
JOIN ShipLocation sl_arrival ON ss.ArrivalLocationId = sl_arrival.LocationId
);

-- Executing Function
SELECT * FROM dbo.fn_GetTotalDistance()