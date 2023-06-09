SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SPS_RotationProcessing]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SPS_RotationProcessing]
GO








CREATE PROCEDURE SPS_RotationProcessing
--T.T 12/21/2004 This stored proc migrate the organizations from the task table

 AS


Declare
	@RotationGroupID as int,
	@RotationID as int,
	@ID as int
 

declare bRef cursor for
Select ID from RotationRun  --where RotationgroupID = @RotationgroupID and RotationID = @RotationID  
open bRef
 fetch next from bRef into @ID
 while @@fetch_Status = 0
	begin
		Select @RotationGroupID = RotationGroupID, @RotationID = RotationID from RotationRun where ID = @ID
		 --**Alerts
		exec  SPS_AlertProcessingReferrals @RotationGroupID, @RotationID
		exec SPS_AlertProcessingMessages @RotationGroupID, @RotationID
		exec SPS_AlertProcessingImports @RotationGroupID, @RotationID
		exec SPS_AlertOrganizationMigrate @RotationGroupID, @RotationID
		--**Criteria
		exec SPS_CriteriaProcessingOrgans @RotationGroupID, @RotationID
		exec SPS_CriteriaProcessingBone @RotationGroupID, @RotationID
		exec SPS_CriteriaProcessingeyes @RotationGroupID, @RotationID
		exec SPS_CriteriaProcessingskin @RotationGroupID, @RotationID
		exec SPS_CriteriaProcessingsoftTissue @RotationGroupID, @RotationID
		exec SPS_CriteriaProcessingvalves @RotationGroupID, @RotationID
		exec SPS_CriteriaProcessingother @RotationGroupID, @RotationID
		exec SPS_CriteriaOrganizationMigrate @RotationGroupID, @RotationID
		--**ServiceLevel
		exec SPS_ServiceLevelProcessing @RotationGroupID, @RotationID
		exec SPS_ServiceLevelOrganizationMigrate @RotationGroupID, @RotationID
		--**sourcecodes
		exec SPS_SourceCodeProcessingReferrals @RotationGroupID,@RotationID
		exec SPS_SourceCodeProcessingMessages @RotationGroupID,@RotationID
		exec SPS_SourceCodeProcessingImports @RotationGroupID,@RotationID
		exec SPS_SourceCodeProcessingInformation @RotationGroupID,@RotationID
		exec  SPS_SourceCodeOrganizationMigrate @RotationGroupID,@RotationID
		--**ReportGroups
		exec SPS_ReportGroupProcessing @RotationGroupID,@RotationID
		exec SPS_ReportGroupOrganizationMigrate @RotationGroupID,@RotationID
		--**schedules
		exec SPS_ScheduleGroupProcessing @RotationGroupID,@RotationID
		exec SPS_ScheduleGroupOrganizationMigrate @RotationGroupID, @RotationID
		
		--**Advance
		exec sps_RotationRemediate @RotationGroupID
		exec SPS_AdvanceRotationDate @RotationGroupID 	
		exec SPI_RotationSequenceAdvance @RotationGroupID	
		Delete from RotationRun where RotationID = @RotationID and RotationGroupID = @RotationGroupID
	
	fetch next from bRef into @ID
	end
close bref 
deallocate bref
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

