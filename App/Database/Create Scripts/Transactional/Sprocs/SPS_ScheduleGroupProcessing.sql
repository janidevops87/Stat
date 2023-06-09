SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_ScheduleGroupProcessing]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_ScheduleGroupProcessing]
GO









CREATE PROCEDURE SPS_ScheduleGroupProcessing 
--T.T 12/21/2004 This stored proc will process the ScheduleGroups  for autoRotation
		@RotationGroupID as int,
		@RotationID as int
AS
Declare
		 
	
	@OrganizationID as int,
	@OrganizationName as varchar(255),
	@RotationScheduleGroupID as int,
	@RotationScheduleGroupName as varchar(255),
	@RotationScheduleGroupType as int,
	@ID as int
	
	 
 declare aRef cursor for
Select ID from RotationOrganization where RotationGroupID = @RotationGroupID 
open aRef
 fetch next from aRef into @ID
 while @@fetch_Status = 0
	begin
		declare InRef cursor for
		Select RotationScheduleGroupType   from RotationScheduleGroup Where RotationGroupID = @RotationGroupID and RotationID = @RotationID
		
		open InRef
		fetch next from InRef into @RotationScheduleGroupType
		while @@fetch_Status = 0
		Begin
			if @RotationScheduleGroupType > 0
				Begin
					Select  @RotationScheduleGroupName = RotationScheduleGroupTypeName   from RotationScheduleGroup Where RotationScheduleGrouptype = @RotationScheduleGrouptype
					--Get RotationOrganizations
					select  @OrganizationID=OrganizationID,@OrganizationName=OrganizationName from RotationOrganization where ID = @ID
					Print @OrganizationID
					Print @OrganizationName
					
					print @RotationSchedulegroupName
				 	print @RotationschedulegroupType
		 			insert into RotationTasks (RotationGroupID,RotationID,Type,TypeID,TypeName,OrganizationID,OrganizationName,StoredProc) values (@RotationGroupID,@RotationID,'RotationScheduleGroup',@RotationScheduleGroupType,@RotationScheduleGroupName,@OrganizationID,@OrganizationName,'SPI_AddScheduleGroupOrganization')
				end
			fetch next from InRef into @RotationScheduleGroupType
		End
		close InRef
		deallocate InRef
		fetch next from aRef into @ID
	end
	
close aref 
deallocate aref

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

