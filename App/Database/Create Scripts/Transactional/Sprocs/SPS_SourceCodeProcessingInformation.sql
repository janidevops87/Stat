SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_SourceCodeProcessingInformation]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_SourceCodeProcessingInformation]
GO






CREATE PROCEDURE SPS_SourceCodeProcessingInformation
--T.T 12/21/2004 This stored proc will process the RotasionSourcecode  for autoRotation
		@RotationGroupID as int,
		@RotationID as int

 AS

Declare
	
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@RotationSourceCodeID as int,
	@RotationSourceCodeName as varchar(255),
	@RotationSourceCodeType as int,
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
		
		Select @RotationSourceCodeID = RotationSourceCodeID,@RotationSourceCodeName = RotationSourceCodeName , @RotationSourceCodeType =RotationSourcecodeType  from RotationSourceCode Where RotationGroupID = @RotationGroupID and RotationID = @RotationID and RotationSourcecodeType = 5
		if @RotationSourceCodeID > 0
			Begin
				--Get RotationOrganizations
				select  @OrganizationID=OrganizationID,@OrganizationName=OrganizationName from RotationOrganization where ID = @ID
				Print @OrganizationID
				Print @OrganizationName
				 
		 		insert into RotationTasks (RotationGroupID,RotationID,Type,TypeID,TypeName,OrganizationID,OrganizationName,StoredProc) values (@RotationGroupID,@RotationID,'RotationSourceCodeInformation',@RotationSourceCodeID,@RotationSourceCodeName,@OrganizationID,@OrganizationName,'SPI_AddSourceCodeOrganization')
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

