SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_SourceCodeOrganizationMigrate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_SourceCodeOrganizationMigrate]
GO






CREATE PROCEDURE SPS_SourceCodeOrganizationMigrate
	 	@vRotationGroupID as int,
		@vRotationID as int
--T.T 12/21/2004 This stored proc migrate the organizations from the task table

 AS


Declare
	@RotationGroupID as int,
	@RotationID as int,
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@RotationSourceCodeID as int,
	@ID as int,
	@storedproc as varchar(255),
	@vQuery as varchar(255),
	@RotationSourceCodeName as varchar(255)
 

declare aRef cursor for
Select ID from Rotationtasks where RotationgroupID = @vRotationgroupID and RotationID = @vRotationID or Type = 'RotationSourceCodeReferrals' or Type = 'RotationSourceCodeMessages' or Type = 'RotationSourceCodeImports' or Type = 'RotationSourceCodeInformation'
open aRef
 fetch next from aRef into @ID
 while @@fetch_Status = 0
	begin
		Select @RotationSourceCodeID= TypeID, @OrganizationID= OrganizationID, @StoredProc = StoredProc from RotationTasks where ID = @ID
		Select @RotationSourceCodeName = SourcecodeName from SourceCode where SourceCodeID = @RotationSourceCodeID
		Print @OrganizationID
		print @StoredProc
		print @RotationSourceCodeName
		
		Exec @StoredProc @RotationSourceCodeID,@OrganizationID
		
		Update SourceCode set SourceCodeRotationActive = -1 where sourceCodeID = @RotationSourcecodeID
	fetch next from aRef into @ID
	end
close aref 
deallocate aref


 	Delete from Rotationtasks where RotationgroupID = @vRotationgroupID and RotationID = @vRotationID  and Type = 'RotationSourceCodeReferrals' or Type = 'RotationSourceCodeMessages' or Type = 'RotationSourceCodeImports' or Type = 'RotationSourceCodeInformation'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

