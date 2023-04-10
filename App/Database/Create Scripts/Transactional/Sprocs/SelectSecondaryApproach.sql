

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectSecondaryApproach')
	BEGIN
		PRINT 'Dropping Procedure SelectSecondaryApproach';
		DROP Procedure SelectSecondaryApproach;
	END
GO

PRINT 'Creating Procedure SelectSecondaryApproach';
GO
CREATE Procedure SelectSecondaryApproach
(
		@CallId int = null
)
AS
/******************************************************************************
**	File: SelectSecondaryApproach.sql
**	Name: SelectSecondaryApproach
**	Desc: Selects multiple rows of SecondaryApproach Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT
		SecondaryApproach.CallId,
		SecondaryApproach.SecondaryApproached,
		SecondaryApproach.SecondaryApproachedBy,
		SecondaryApproach.SecondaryApproachType,
		SecondaryApproach.SecondaryApproachOutcome,
		SecondaryApproach.SecondaryApproachReason,
		SecondaryApproach.SecondaryConsented,
		SecondaryApproach.SecondaryConsentBy,
		SecondaryApproach.SecondaryConsentOutcome,
		SecondaryApproach.SecondaryConsentResearch,
		SecondaryApproach.SecondaryRecoveryLocation,
		SecondaryApproach.SecondaryHospitalApproach,
		SecondaryApproach.SecondaryHospitalApproachedBy,
		SecondaryApproach.SecondaryHospitalOutcome,
		SecondaryApproach.SecondaryConsentMedSocPaperwork,
		SecondaryApproach.SecondaryConsentMedSocObtainedBy,
		SecondaryApproach.SecondaryConsentFuneralPlans,
		SecondaryApproach.SecondaryConsentFuneralPlansOther,
		SecondaryApproach.SecondaryConsentLongSleeves,
		SecondaryApproach.LastStatEmployeeID,
		SecondaryApproach.AuditLogTypeID,
		SecondaryApproach.LastModified
	FROM 
		dbo.SecondaryApproach 
	WHERE 
		@CallId IS NULL OR SecondaryApproach.CallId = @CallId;
	
GO

GRANT EXEC ON SelectSecondaryApproach TO PUBLIC;
GO
