SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_DeleteServiceLevel]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_DeleteServiceLevel]
GO








CREATE PROCEDURE SPD_DeleteServiceLevel
--T.T 12/21/2004 This stored proc will delete Alerts
	@RotationGroupID as int,
	@RotationID as int

 AS

Declare

	@ID as int,
	@ServiceLevelRotationID as int,
	@Ans as int,
	@DeleteOrg as int,
	@OrganizationID as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

 Select @ServiceLevelRotationID= ServiceLevelID from Rotation  where RotationGroupID = @RotationGroupID and RotationID = @RotationID
 UPDATE ServiceLevel SET WorkingStatusUpdatedFlag = 1 WHERE ServiceLevelID = @ServiceLevelRotationID
declare aRef cursor for
--DELETE FROM ServiceLevel30Organization WHERE ServiceLevelID = 86 AND OrganizationID = 10708
	SELECT Distinct ServiceLevelOrganizationID  FROM ServiceLevel30Organization WHERE  ServiceLevelID  = @ServiceLevelRotationID
 
	open aRef
	 fetch next from aRef into @ID
 	while @@fetch_Status = 0
			begin			
									Set @ans = 0
									select @OrganizationID = organizationID,@DeleteOrg =ServiceLevelOrganizationID FROM ServiceLevel30Organization WHERE  ServiceLevelOrganizationID =  @ID ;						
									select @ans = OrganizationID from rotationorganization where OrganizationID = @OrganizationID and RotationGroupID = @RotationGroupID
									if @Ans > 0 	
										begin
											DELETE FROM ServiceLevel30Organization WHERE ServiceLevelOrganizationID =@DeleteOrg
 											print @organizationID
											print @DeleteOrg
										end 
				
			fetch next from aRef into @ID
	 		end
close aref 
deallocate aref


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

