SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_DeleteCriteria]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_DeleteCriteria]
GO













CREATE PROCEDURE SPD_DeleteCriteria
--T.T 12/21/2004 This stored proc will deletecriteria when it is remediated in a rotation
	@RotationGroupID as int,
	@RotationID as int

 AS

Declare
	@ID as int,
	@IDout as int,
	@CriteriaRotationID as int,
	@Ans as int,
	@DeleteOrg as int,
	@OrganizationID as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

declare outRef cursor for
	Select  CriteriagroupID from RotationCriteria where RotationGroupID = @RotationGroupID and RotationID = @RotationID
	open outRef
	fetch next from outRef into @IDout
	while @@fetch_Status = 0
		begin
			select @CriteriaRotationID = @IDout
			UPDATE Criteria SET WorkingStatusUpdatedFlag = 1 WHERE CriteriaID = @CriteriaRotationID
			--print @criteriaRotationID
			declare aRef cursor for
			SELECT DISTINCT CriteriaOrganization.CriteriaOrganizationID FROM CriteriaOrganization WHERE   CriteriaOrganization.CriteriaID = @CriteriaRotationID 
			
			open aRef
	 		fetch next from aRef into @ID
 			while @@fetch_Status = 0
				begin
					select @CriteriaRotationID = @ID
					Print @CriteriaRotationID

					 				Set @ans = 0
									select @OrganizationID = organizationID,@DeleteOrg =CriteriaOrganizationID FROM CriteriaOrganization WHERE  CriteriaOrganizationID =  @ID ;						
									select @ans = OrganizationID from rotationorganization where OrganizationID = @OrganizationID and RotationGroupID = @RotationGroupID
									if @Ans > 0 	
										begin
											DELETE FROM CriteriaOrganization WHERE CriteriaOrganizationID =@DeleteOrg
 
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

