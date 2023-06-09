SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_DeleteScheduleGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_DeleteScheduleGroup]
GO





CREATE PROCEDURE SPD_DeleteScheduleGroup
--T.T 12/21/2004 This stored proc will deletecriteria when it is remediated in a rotation
	@RotationGroupID as int,
	@RotationID as int

 AS

Declare
	@ID as int,
	@IDout as int,
	@ScheduleGroupRotationID as int,
	@ScheduleGroupID as int,
	@Ans as int,
	@OrganizationID as int,
	@DeleteOrg as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

declare outRef cursor for
	Select  RotationScheduleGroupType from RotationScheduleGroup where RotationGroupID = @RotationGroupID and RotationID = @RotationID
	open outRef
	fetch next from outRef into @IDout
	while @@fetch_Status = 0
		begin
			select @ScheduleGroupRotationID = @IDout

			--print @criteriaRotationID
			declare aRef cursor for
			SELECT DISTINCT  schedulegroupOrganizationID  FROM ScheduleGroupOrganization WHERE   scheduleGroupID  = @ScheduleGroupRotationID 
			open aRef
	 		fetch next from aRef into @ID
 			while @@fetch_Status = 0
				begin
					select @ScheduleGroupID = @ID
					  				Set @ans = 0
									select @OrganizationID = organizationID,@DeleteOrg =ScheduleGroupOrganizationID FROM ScheduleGroupOrganization WHERE  ScheduleGroupOrganizationID =  @ID ;						
									select @ans = OrganizationID from rotationorganization where OrganizationID = @OrganizationID and RotationGroupID = @RotationGroupID
									if @Ans > 0 	
										begin
											DELETE FROM ScheduleGroupOrganization WHERE ScheduleGroupOrganizationID =  @DeleteOrg ;
										end
					
		
			fetch next from aRef into @ID
			 end
			close aref 
			deallocate aref
		
		fetch next from outRef into @IDout
	end

close outref
deallocate outref


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

