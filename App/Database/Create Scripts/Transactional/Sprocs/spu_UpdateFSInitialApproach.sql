SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spu_UpdateFSInitialApproach]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spu_UpdateFSInitialApproach]
GO



CREATE PROCEDURE spu_UpdateFSInitialApproach

@CallID Int = null, 
@ApproachType smallint = null,
@ApproachedBy Int = null,
@ApproachOutcome Smallint = null

AS

/* ccarroll 09/13/2006 StatTrac 8.0 Iteration 2 (4.1.4.3.3)
Update FS Initial Approach Information with data from Triage side. */


UPDATE SecondaryApproach 
	SET SecondaryHospitalApproach = @ApproachType,
	    SecondaryHospitalApproachedBy = @ApproachedBy,
	    SecondaryHospitalOutcome = @ApproachOutcome
WHERE CallID = @CallID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

