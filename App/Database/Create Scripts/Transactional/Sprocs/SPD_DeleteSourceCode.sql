SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_DeleteSourceCode]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_DeleteSourceCode]
GO









CREATE PROCEDURE SPD_DeleteSourceCode
--T.T 12/21/2004 This stored proc will deletecriteria when it is remediated in a rotation
	@RotationGroupID as int,
	@RotationID as int

 AS

Declare
	
	@ID as int,
	@IDB as int,
	@IDout as int,
	@OrganizationID as int,
	@DeleteOrg as int,
	@ANS as int,
	@sourceCodeRotationID as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

declare outRef cursor for
	Select  RotationSourceCodeID from RotationSourceCode where RotationGroupID = @RotationGroupID and RotationID = @RotationID
	
	open outRef
	fetch next from outRef into @IDout
	while @@fetch_Status = 0
		begin
			select @sourceCodeRotationID = @IDout
			Update SourceCode set SourceCodeRotationActive = 0 where sourceCodeID = @IDout
			--print @criteriaRotationID
			declare aRef cursor for
			SELECT DISTINCT SourceCodeOrganizationID  FROM sourceCodeOrganization WHERE   SourceCodeID  = @SourceCodeRotationID 
			open aRef	--*****Second cursor
	 		fetch next from aRef into @ID
 			while @@fetch_Status = 0
				begin
					select @SourceCodeRotationID = @ID
					
									Set @ans = 0
									select @OrganizationID = organizationID,@DeleteOrg = SourceCodeOrganizationID FROM SourceCodeOrganization WHERE SourceCodeOrganizationID =  @ID ;						
									select @ans = OrganizationID from rotationorganization where OrganizationID = @OrganizationID and RotationGroupID = @RotationGroupID
									if @Ans > 0 	
										begin
											
											DELETE FROM SourceCodeOrganization WHERE SourceCodeOrganizationID =  @DeleteOrg ;
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

