SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_DeleteReportGroup]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_DeleteReportGroup]
GO





CREATE PROCEDURE SPD_DeleteReportGroup
--T.T 12/21/2004 This stored proc will deleteReportGroup when it is remediated in a rotation
	@RotationGroupID as int,
	@RotationID as int

 AS

Declare
	@ID as int,
	@IDout as int,
	@ReportGroupRotationID as int,
	@ReportGroupID as int,
	@Ans as int,
	@OrganizationID as int,
	@DeleteOrg as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

declare outRef cursor for
	Select  RotationReportGroupType from RotationReportGroup where RotationGroupID = @RotationGroupID and RotationID = @RotationID
	open outRef
	fetch next from outRef into @IDout
	while @@fetch_Status = 0
		begin
			select @ReportGroupRotationID = @IDout

			--print @criteriaRotationID
			declare aRef cursor for
			SELECT DISTINCT WebReportGroupOrgID  FROM WebReportGroupOrg  WHERE  WebReportGroupID  = @ReportGroupRotationID
			open aRef
	 		fetch next from aRef into @ID
 			while @@fetch_Status = 0
				begin
					select @ReportGroupID = @ID
					 Set @ans = 0
									select @OrganizationID = organizationID,@DeleteOrg =WebReportGroupOrgID FROM WebReportGroupOrg WHERE  WebReportGroupOrgID =  @ID ;						
									select @ans = OrganizationID from rotationorganization where OrganizationID = @OrganizationID and RotationGroupID = @RotationGroupID
									if @Ans > 0 	
										begin
											DELETE FROM WebReportGroupOrg WHERE WebReportGroupOrgID =  @DeleteOrg;
 
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

