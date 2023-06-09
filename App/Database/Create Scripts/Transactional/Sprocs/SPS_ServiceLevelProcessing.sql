SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_ServiceLevelProcessing]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_ServiceLevelProcessing]
GO






CREATE PROCEDURE SPS_ServiceLevelProcessing
--T.T 12/21/2004 This stored proc will process the criteria Type 7(Other) for autoRotation
		@RotationGroupID as int,
		@RotationID as int

 AS

Declare
	
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@ServiceLevelID as int,
	@ServiceLevelName as varchar(255),
	@ID as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

print @RotationGroupID
print @RotationID


declare aRef cursor for
Select ID from RotationOrganization where RotationGroupID = @RotationGroupID 
open aRef
 fetch next from aRef into @ID
 while @@fetch_Status = 0
	begin
		--CriteriaType 0 = Organ
		Select @ServiceLevelID = ServiceLevelID,@ServiceLevelName =ServiceLevelName  from Rotation Where RotationGroupID = @RotationGroupID and RotationID = @RotationID  
		if @ServiceLevelID > 0
			Begin
				--Get RotationOrganizations
				select  @OrganizationID=OrganizationID,@OrganizationName=OrganizationName from RotationOrganization where ID = @ID
				Print @OrganizationID
				Print @OrganizationName
				--Get AlertID
		
		
				Print @ServiceLevelName
		 		insert into RotationTasks (RotationGroupID,RotationID,Type,TypeID,TypeName,OrganizationID,OrganizationName,StoredProc) values (@RotationGroupID,@RotationID,'ServiceLevel',@ServiceLevelID,@ServiceLevelName,@OrganizationID,@OrganizationName,'SPI_AddServiceLevelOrganization')
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

