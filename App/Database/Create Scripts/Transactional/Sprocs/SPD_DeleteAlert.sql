SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_DeleteAlert]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_DeleteAlert]
GO









CREATE PROCEDURE SPD_DeleteAlert
--T.T 12/21/2004 This stored proc will delete Alerts
	@RotationGroupID as int,
	@RotationID as int

 AS

Declare

	@ID as int,
	@AlertRotationID as int,
	@Ans as int,
	@OrganizationID as int,
	@Deleteorg as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

 Select @AlertRotationID= AlertID from RotationAlerts where RotationGroupID = @RotationGroupID and RotationID = @RotationID
print @AlertRotationID
declare aRef cursor for
	SELECT DISTINCT AlertOrganization.AlertOrganizationID FROM AlertOrganization WHERE   AlertOrganization.AlertID = @AlertRotationID 
	open aRef
	 fetch next from aRef into @ID
 	while @@fetch_Status = 0
			begin
				select @AlertRotationID = @ID
									 Set @ans = 0
									select @OrganizationID = organizationID,@DeleteOrg =AlertOrganizationID FROM AlertOrganization WHERE  AlertOrganizationID =  @ID ;						
									select @ans = OrganizationID from rotationorganization where OrganizationID = @OrganizationID and RotationGroupID = @RotationGroupID
									if @Ans > 0 	
										begin
											DELETE FROM AlertOrganization WHERE AlertOrganizationID =@DeleteOrg
 
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

