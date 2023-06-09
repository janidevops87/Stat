SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_ReportGroupOrganizationMigrate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_ReportGroupOrganizationMigrate]
GO






CREATE PROCEDURE SPS_ReportGroupOrganizationMigrate
	 	@vRotationGroupID as int,
		@vRotationID as int
--T.T 12/21/2004 This stored proc migrate the organizations from the task table

 AS


Declare
	@RotationGroupID as int,
	@RotationID as int,
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@RotationReportGroupID as int,
	@ID as int,
	@storedproc as varchar(255),
	@vQuery as varchar(255)
 

declare aRef cursor for
Select ID from Rotationtasks where RotationgroupID = @vRotationgroupID and RotationID = @vRotationID and Type = 'RotationReportGroup'  
open aRef
 fetch next from aRef into @ID
 while @@fetch_Status = 0
	begin
		Select @RotationReportGroupID= TypeID, @OrganizationID= OrganizationID, @StoredProc = StoredProc from RotationTasks where ID = @ID
		Print @OrganizationID
		print @StoredProc
		Exec @StoredProc @RotationReportGroupID,@OrganizationID
	fetch next from aRef into @ID
	end
close aref 
deallocate aref


 	Delete from Rotationtasks where RotationgroupID = @vRotationgroupID and RotationID = @vRotationID  and Type = 'RotationReportGroup'



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

