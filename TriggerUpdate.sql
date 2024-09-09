-- After Trigger Update (ShipShip Table)

Create trigger trgShipUpdate
on ShipShip
for Update
as
Begin

      Declare @ShipId int
      Declare @OldCarrierId INT, @NewCarrierId INT
      Declare @OldDepatureLocationId int, @NewDepatureLocationId int
      Declare @OldArrivalLocationId INT , @NewArrivalLocationId INT
      Declare @OldDepatureDate DATE, @NewDepatureDate DATE
      Declare @OldArrivalDate DATE, @NewArrivalDate DATE
      DECLARE @OldStatus NVARCHAR(50), @NewStatus NVARCHAR(50)  
     
      Declare @AuditString nvarchar(1000)
    
      Select * into #TempTable from inserted
     

      While(Exists(Select ShipId from #TempTable))
      Begin
            Set @AuditString = ''
            Select Top 1 @ShipId = ShipId, @NewCarrierId = CarrierId, @NewDepatureLocationId = DepatureLocationId, 
                         @NewArrivalLocationId = ArrivalLocationId,@NewDepatureDate=DepatureDate,@NewArrivalDate=ArrivalDate,@NewStatus = Status
            from #TempTable
           
            Select @OldCarrierId = CarrierId, @OldDepatureLocationId = DepatureLocationId, @OldArrivalLocationId = ArrivalLocationId, 
                   @OldDepatureDate = DepatureDate,@OldArrivalDate = ArrivalDate, @OldStatus = Status
            from deleted where ShipId = @ShipId

            Set @AuditString = 'Ship with Id = ' + Cast(@ShipId as nvarchar(4)) + ' changed'
            
            if(@OldCarrierId <> @NewCarrierId)
                  Set @AuditString = @AuditString + ' Carrier Id from ' + CAST(@OldCarrierId as nvarchar(20)) + ' to ' + CAST(@NewCarrierId as nvarchar(50))
                 
            if(@OldDepatureLocationId <> @NewDepatureLocationId)
                  Set @AuditString = @AuditString + ' DepatureLocationId from ' + CAST(@OldDepatureLocationId as nvarchar(50)) + ' to ' + 
                                                                                                       CAST(@NewDepatureLocationId as nvarchar(50))
                 
            if(@OldArrivalLocationId <> @NewArrivalLocationId)
                  Set @AuditString = @AuditString + ' ArrivalLocationId from ' + Cast(@OldArrivalLocationId as nvarchar(10))+ ' to ' + 
                                                                                                       Cast(@NewArrivalLocationId as nvarchar(10))
                  
            if(@OldDepatureDate <> @NewDepatureDate)
                  Set @AuditString = @AuditString + ' DepatureDate from ' + Cast(@OldDepatureDate as nvarchar(20))+ ' to ' + 
                                                                                                       Cast(@NewDepatureDate as nvarchar(20))
                                                                                                                         
            if(@OldArrivalDate <> @NewArrivalDate)
                  Set @AuditString = @AuditString + ' DepatureDate from ' + Cast(@OldArrivalDate as nvarchar(20))+ ' to ' + 
                                                                                                       Cast(@NewArrivalDate as nvarchar(20))

             if(@OldStatus <> @NewStatus)
                  Set @AuditString = @AuditString + ' DepatureDate from ' + @OldStatus + ' to ' + @NewStatus 
                                                                                                       
           
            insert into LogTable values(@AuditString)

            Delete from #TempTable where ShipId = @ShipId
      End
End