SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPD_DeleteSourceCode2]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPD_DeleteSourceCode2]
GO






CREATE PROCEDURE SPD_DeleteSourceCode2
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
	@sourceCodeRotationID as int

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

declare outRef cursor for
	Select  RotationSourceCodeID from RotationSourceCode where RotationGroupID = @RotationGroupID and RotationID = @RotationID
	open outRef
	fetch next from outRef into @IDout
	while @@fetch_Status = 0
		begin
			select @sourceCodeRotationID = @IDout

			--print @criteriaRotationID
			declare aRef cursor for
			SELECT DISTINCT SourceCodeOrganizationID  FROM sourceCodeOrganization WHERE   SourceCodeID  = @SourceCodeRotationID 
			open aRef	--*****Second cursor
	 		fetch next from aRef into @ID
 			while @@fetch_Status = 0
				begin
					select @SourceCodeRotationID = @ID
					 
					--*** Third cursor
					declare bRef cursor for
					Select sourcecodeOrganizationID from SourcecodeOrganization  WHERE SourceCodeOrganizationID =  @SourceCodeRotationID ;
					open bRef
					fetch next from bRef into @IDB	
					while @@fetch_Status = 0
						begin
							set @DeleteOrg = 0
							select @OrganizationID = OrganizationID from SourceCodeOrganization Where  SourceCodeOrganizationID = @IDB
							Select @DeleteOrg = OrganizationID from RotationOrganization where OrganizationID = @OrganizationID and RotationGroupID = @RotationGroupID
							
							 IF @DeleteOrg >0 
								Begin
									Print @DeleteOrg
									--DELETE FROM SourceCodeOrganization WHERE SourceCodeOrganizationID =  @IDB ;
								End
						fetch next from bRef into @IDB
						End	
						close bRef 
						deallocate bRef
						
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

