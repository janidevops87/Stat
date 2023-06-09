SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_ReportGroupProcessing]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_ReportGroupProcessing]
GO







CREATE PROCEDURE SPS_ReportGroupProcessing 
--T.T 12/21/2004 This stored proc will process theReportGroups  for autoRotation
		@RotationGroupID as int,
		@RotationID as int

 AS

Declare
	
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@RotationReportGroupID as int,
	@RotationReportGroupTypeName as varchar(255),
	@RotationReportGroupType as int,
	@ID as int,
	@StartAccessDate as datetime,
	@EndAccessDate as datetime

declare aRef cursor for
Select ID from RotationOrganization where RotationGroupID = @RotationGroupID 
open aRef
 fetch next from aRef into @ID
 while @@fetch_Status = 0
	begin
		declare InRef cursor for
		Select  RotationReportGroupType   from RotationReportGroup Where RotationGroupID = @RotationGroupID and RotationID = @RotationID
		Open InRef
			fetch next from InRef into @RotationReportGroupType
			while @@fetch_Status = 0
				Begin
				Select  @RotationReportGroupTypeName = RotationReportGrouptypeName   from RotationReportGroup Where RotationReportGrouptype  = @RotationReportGroupType
				if @RotationReportGroupType > 0
				Begin
					--Get RotationOrganizations
					select  @OrganizationID=OrganizationID,@OrganizationName=OrganizationName from RotationOrganization where ID = @ID
					Print @OrganizationID
					Print @OrganizationName
					Print @RotationReportGroupType
					print @RotationReportGroupTypeName
				 
		 			insert into RotationTasks (RotationGroupID,RotationID,Type,TypeID,TypeName,OrganizationID,OrganizationName,StoredProc) values (@RotationGroupID,@RotationID,'RotationReportGroup',@RotationReportGroupType,@RotationReportGroupTypeName,@OrganizationID,@OrganizationName,'SPI_AddReportGroupOrganization')
				
				end
			fetch next from InRef into @RotationReportGroupType
			end
			close InRef
			deallocate InRef
		fetch next from aRef into @ID
	end
	Select @StartAccessDate = RotationNextRun, @EndAccessDate = RotationReportAccessDate from Rotation where RotationGroupID = @RotationGroupID and RotationID = @RotationID
	exec SPI_AddWebReportGroupOrganization @RotationGroupID,@RotationID,@RotationReportGroupID,@StartAccessDate,@EndAccessDate
close aref 
deallocate aref

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

