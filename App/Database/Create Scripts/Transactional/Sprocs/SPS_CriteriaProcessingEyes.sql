SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_CriteriaProcessingEyes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_CriteriaProcessingEyes]
GO






CREATE PROCEDURE SPS_CriteriaProcessingEyes
--T.T 12/21/2004 This stored proc will process the criteria Type 6(Eyes) for autoRotation
		@RotationGroupID as int,
		@RotationID as int

 AS

Declare
	
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@CriteriaID as int,
	@CriteriaGroupName as varchar(255),
	@CriteriaType as int,
	@CriteriaGroupID as int,
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
		Select @CriteriaID = CriteriaID,@CriteriaGroupName = CriteriaGroupName , @CriteriaGroupID = CriteriaGroupID from RotationCriteria Where RotationGroupID = @RotationGroupID and RotationID = @RotationID and CriteriaType = 6
		if @CriteriaGroupID > 0
			Begin
				--Get RotationOrganizations
				select  @OrganizationID=OrganizationID,@OrganizationName=OrganizationName from RotationOrganization where ID = @ID
				Print @OrganizationID
				Print @OrganizationName
				--Get AlertID
		
		
				Print @CriteriaGroupName
		 		insert into RotationTasks (RotationGroupID,RotationID,Type,TypeID,TypeName,OrganizationID,OrganizationName,StoredProc) values (@RotationGroupID,@RotationID,'CriteriaEyes',@CriteriaGroupID,@CriteriaGroupName,@OrganizationID,@OrganizationName,'SPI_AddCriteriaOrganization')
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

