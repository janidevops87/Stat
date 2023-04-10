IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateSecondaryApproach')
	BEGIN
		PRINT 'Dropping Procedure UpdateSecondaryApproach'
		DROP  Procedure  UpdateSecondaryApproach
	END

GO

PRINT 'Creating Procedure UpdateSecondaryApproach'
GO
CREATE Procedure UpdateSecondaryApproach
	@CallId int , 
	@SecondaryApproached smallint = NULL, 
	@SecondaryApproachedBy int = NULL, 
	@SecondaryApproachType smallint = NULL, 
	@SecondaryApproachOutcome smallint = NULL, 
	@SecondaryApproachReason smallint = NULL, 
	@SecondaryConsented smallint = NULL, 
	@SecondaryConsentBy int = NULL, 
	@SecondaryConsentOutcome smallint = NULL, 
	@SecondaryConsentResearch smallint = NULL, 
	@SecondaryRecoveryLocation varchar(50) = NULL, 
	@SecondaryHospitalApproach smallint = NULL, 
	@SecondaryHospitalApproachedBy int = NULL, 
	@SecondaryHospitalOutcome smallint = NULL, 
	@SecondaryConsentMedSocPaperwork smallint = NULL, 
	@SecondaryConsentMedSocObtainedBy int = NULL, 
	@SecondaryConsentFuneralPlans smallint = NULL, 
	@SecondaryConsentFuneralPlansOther varchar(50) = NULL, 
	@SecondaryConsentLongSleeves smallint = NULL, 
	@LastStatEmployeeID int , 
	@AuditLogTypeID int = NULL

AS

/******************************************************************************
**		File: UpdateSecondaryApproach.sql
**		Name: UpdateSecondaryApproach
**		Desc: 
**			Updates data into the SecondaryApproach table
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**     see list above
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      7/02/2007	Bret Knoll			8.4.3.8 AuditTrail
*******************************************************************************/

UPDATE 
	SecondaryApproach 
SET
	SecondaryApproached = ISNULL(@SecondaryApproached, SecondaryApproached), 
	SecondaryApproachedBy = ISNULL(@SecondaryApproachedBy, SecondaryApproachedBy), 
	SecondaryApproachType = ISNULL(@SecondaryApproachType, SecondaryApproachType), 
	SecondaryApproachOutcome = ISNULL(@SecondaryApproachOutcome, SecondaryApproachOutcome), 
	SecondaryApproachReason = ISNULL(@SecondaryApproachReason, SecondaryApproachReason), 
	SecondaryConsented = ISNULL(@SecondaryConsented, SecondaryConsented), 
	SecondaryConsentBy = ISNULL(@SecondaryConsentBy, SecondaryConsentBy), 
	SecondaryConsentOutcome = ISNULL(@SecondaryConsentOutcome, SecondaryConsentOutcome), 
	SecondaryConsentResearch = ISNULL(@SecondaryConsentResearch, SecondaryConsentResearch), 
	SecondaryRecoveryLocation = @SecondaryRecoveryLocation, 
	SecondaryHospitalApproach = ISNULL(@SecondaryHospitalApproach, SecondaryHospitalApproach), 
	SecondaryHospitalApproachedBy = ISNULL(@SecondaryHospitalApproachedBy, SecondaryHospitalApproachedBy), 
	SecondaryHospitalOutcome = ISNULL(@SecondaryHospitalOutcome, SecondaryHospitalOutcome), 
	SecondaryConsentMedSocPaperwork = ISNULL(@SecondaryConsentMedSocPaperwork, SecondaryConsentMedSocPaperwork), 
	SecondaryConsentMedSocObtainedBy = ISNULL(@SecondaryConsentMedSocObtainedBy, SecondaryConsentMedSocObtainedBy), 
	SecondaryConsentFuneralPlans = ISNULL(@SecondaryConsentFuneralPlans, SecondaryConsentFuneralPlans), 
	SecondaryConsentFuneralPlansOther = @SecondaryConsentFuneralPlansOther, 
	SecondaryConsentLongSleeves = ISNULL(@SecondaryConsentLongSleeves, SecondaryConsentLongSleeves), 
	LastStatEmployeeID = @LastStatEmployeeID, 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3), --  3 = Modify		 
	LastModified = GetDate() 

WHERE 
	CallID = @CallId



GO

GRANT EXEC ON UpdateSecondaryApproach TO PUBLIC

GO
