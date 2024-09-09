-- After Trigger Insert (ShipShip Table)

CREATE TRIGGER trg_ShipShipInsert
ON ShipShip
AFTER INSERT
AS
BEGIN
     DECLARE @Id INT 
     SELECT @Id = ShipId from inserted
INSERT INTO LogTable
VALUES ('New Ship with Id ='+CAST(@Id as nvarchar(50))+' is added at '+CAST(GETDATE() as nvarchar(20)))
END;

-- After Trigger Delete (ShipShip Table)

CREATE TRIGGER trg_ShipShipDelete
ON ShipShip
AFTER DELETE
AS
BEGIN
 Declare @Id int
 Select @Id = ShipId from deleted
 
 insert into LogTable 
 values('An existing Ship with Id  = ' + Cast(@Id as nvarchar(5)) + ' is deleted at ' + Cast(Getdate() as nvarchar(20)))
END
