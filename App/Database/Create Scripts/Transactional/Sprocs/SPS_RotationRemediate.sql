SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_RotationRemediate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_RotationRemediate]
GO







CREATE PROCEDURE SPS_RotationRemediate
--T.T 12/21/2004 This stored procedure will delete the groups that need to be remediated
		@RotationGroupID as int
		 

 AS

Declare
	@RotationRemediate as int,
	@MaxRotation as int,
	@MinRotation as int,
	@currentRotation as int


	select @MaxRotation = Max(RotationID) from rotation where rotationGroupID = @RotationGroupID
	select @Minrotation = Min(RotationID) from rotation where rotationgroupID = @RotationGroupID
	select @Currentrotation = RotationID from rotation where rotationremediate = -1 and rotationgroupid = @RotationGroupID
--Print @maxrotation
--Print @MinRotation
--Print @Currentrotation


select @RotationRemediate = @CurrentRotation
 
	

 
	 

--select @RotationGroupID = RotationGroupID, @RotationID = RotationID  from Rotation where RotationNextRun < current_timestamp and currentRotation = -1

		--CriteriaType 0 = Organ
		--Select @RotationRemediate = RotationID  from Rotation  Where RotationGroupID = @RotationGroupID and RotationRemediate = -1
		
		exec SPD_DeleteAlert @RotationGroupID, @RotationRemediate
		exec SPD_DeleteCriteria @RotationGroupID, @RotationRemediate
		exec SPD_DeleteServiceLevel @RotationGroupID, @RotationRemediate
		exec SPD_DeleteScheduleGroup @RotationGroupID, @RotationRemediate
		exec SPD_DeleteReportGroup  @RotationGroupID, @RotationRemediate
		exec SPD_DeleteSourceCode @RotationGroupID, @RotationRemediate

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

