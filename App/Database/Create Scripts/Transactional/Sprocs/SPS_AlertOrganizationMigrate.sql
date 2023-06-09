SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_AlertOrganizationMigrate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_AlertOrganizationMigrate]
GO






CREATE PROCEDURE SPS_AlertOrganizationMigrate
	 @vRotationGroupID as int,
		@vRotationID as int
--T.T 12/21/2004 This stored proc migrate the organizations from the task table

 AS


Declare
	@RotationGroupID as int,
	@RotationID as int,
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@AlertID as int,
	@AlertGroupName as varchar(255),
	@ID as int,
	@storedproc as varchar(255),
	@vQuery as varchar(255)
 

declare aRef cursor for
Select ID from Rotationtasks where RotationgroupID = @vRotationgroupID and RotationID = @vRotationID and Type = 'AlertReferrals' or Type = 'AlertMessages' or Type = 'AlertImports'
open aRef
 fetch next from aRef into @ID
 while @@fetch_Status = 0
	begin
		Select @AlertID= TypeID, @OrganizationID= OrganizationID, @StoredProc = StoredProc from RotationTasks where ID = @ID
		Print @AlertID
		Print @OrganizationID
		print @StoredProc
		Exec @StoredProc @AlertID,@OrganizationID
	fetch next from aRef into @ID
	end
close aref 
deallocate aref


 	Delete from Rotationtasks where RotationgroupID = @vRotationgroupID and RotationID = @vRotationID and Type = 'AlertReferrals' or Type = 'AlertMessages' or Type = 'AlertImports'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

