IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertSecondaryApproach')
	BEGIN
		PRINT 'Dropping Procedure InsertSecondaryApproach'
		DROP  Procedure  InsertSecondaryApproach
	END

GO

PRINT 'Creating Procedure InsertSecondaryApproach'
GO
CREATE Procedure InsertSecondaryApproach
	@CallId int, 
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
	@LastStatEmployeeID int 

AS

/******************************************************************************
**		File: InsertSecondaryApproach.sql
**		Name: InsertSecondaryApproach
**		Desc: 
**			Inserts data into the SecondaryApproach table
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

INSERT 
	SecondaryApproach 
	(
		CallId,
		SecondaryApproached,
		SecondaryApproachedBy,
		SecondaryApproachType,
		SecondaryApproachOutcome,
		SecondaryApproachReason,
		SecondaryConsented,
		SecondaryConsentBy,
		SecondaryConsentOutcome,
		SecondaryConsentResearch,
		SecondaryRecoveryLocation,
		SecondaryHospitalApproach,
		SecondaryHospitalApproachedBy,
		SecondaryHospitalOutcome,
		SecondaryConsentMedSocPaperwork,
		SecondaryConsentMedSocObtainedBy,
		SecondaryConsentFuneralPlans,
		SecondaryConsentFuneralPlansOther,
		SecondaryConsentLongSleeves,
		LastStatEmployeeID,
		AuditLogTypeID,
		LastModified
	) 

VALUES 
	( 
		@CallId, 
		@SecondaryApproached, 
		@SecondaryApproachedBy, 
		@SecondaryApproachType, 
		@SecondaryApproachOutcome, 
		@SecondaryApproachReason, 
		@SecondaryConsented, 
		@SecondaryConsentBy, 
		@SecondaryConsentOutcome, 
		@SecondaryConsentResearch, 
		@SecondaryRecoveryLocation, 
		@SecondaryHospitalApproach, 
		@SecondaryHospitalApproachedBy, 
		@SecondaryHospitalOutcome, 
		@SecondaryConsentMedSocPaperwork, 
		@SecondaryConsentMedSocObtainedBy, 
		@SecondaryConsentFuneralPlans, 
		@SecondaryConsentFuneralPlansOther, 
		@SecondaryConsentLongSleeves, 
		@LastStatEmployeeID, 
		1, -- @AuditLogTypeID 1 = Created
		GetDate()-- @LastModified, 
		
	) 

SELECT 
	CallId,
	SecondaryApproached,
	SecondaryApproachedBy,
	SecondaryApproachType,
	SecondaryApproachOutcome,
	SecondaryApproachReason,
	SecondaryConsented,
	SecondaryConsentBy,
	SecondaryConsentOutcome,
	SecondaryConsentResearch,
	SecondaryRecoveryLocation,
	SecondaryHospitalApproach,
	SecondaryHospitalApproachedBy,
	SecondaryHospitalOutcome,
	SecondaryConsentMedSocPaperwork,
	SecondaryConsentMedSocObtainedBy,
	SecondaryConsentFuneralPlans,
	SecondaryConsentFuneralPlansOther,
	SecondaryConsentLongSleeves
FROM 
	SecondaryApproach 
WHERE 
	SecondaryApproached = @CallId




GO

GRANT EXEC ON InsertSecondaryApproach TO PUBLIC

GO
