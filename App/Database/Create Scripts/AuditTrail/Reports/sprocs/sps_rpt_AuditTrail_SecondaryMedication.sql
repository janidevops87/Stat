IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_SecondaryMedication')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_SecondaryMedication';
		DROP  PROCEDURE  sps_rpt_AuditTrail_SecondaryMedication;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_SecondaryMedication';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_SecondaryMedication
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_SecondaryMedication.sql
**		Name: sps_rpt_AuditTrail_SecondaryMedication
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: christopher carroll
**		Date: 08/07/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		08/07/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/29/2008		ccarroll				Added ILB functionality in update sproc
**		11/05/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #MedInfo;


/* Set UserOrgTZ Time Zone */
DECLARE @UserOrgTZ AS varchar(2) =
(
	SELECT vwAuditTrailTimeZone.TimeZoneAbbreviation 
	FROM vwAuditTrailOrganization
		JOIN vwAuditTrailTimeZone ON vwAuditTrailOrganization.TimeZoneId = vwAuditTrailTimeZone.TimeZoneID
	WHERE OrganizationID = @UserOrgID
);

IF @ChangeStartDateTime = @ChangeEndDateTime
	BEGIN
		SELECT
			@ChangeStartDateTime = NULL,
			@ChangeEndDateTime = NULL;
	END
ELSE /* Adjust UserInputDateTime */
	BEGIN
		SELECT
			@ChangeStartDateTime =  DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeStartDateTime) * -1), @ChangeStartDateTime),
			@ChangeEndDateTime = DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeEndDateTime) * -1), @ChangeEndDateTime);
	END


SELECT DISTINCT
/* SecondaryMedication * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, SecondaryMedication.LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',
	SecondaryMedicationChangePerson.PersonFirst + ' ' + SecondaryMedicationChangePerson.PersonLast AS 'ChangeUser',
	SecondaryMedicationChangeType.AuditLogTypeName AS 'ChangeType',
	MedicationList.MedicationName
INTO #MedInfo
FROM
	SecondaryMedication
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = SecondaryMedication.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryMedicationChangeEmployee ON SecondaryMedicationChangeEmployee.StatEmployeeID = SecondaryMedication.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson SecondaryMedicationChangePerson ON SecondaryMedicationChangePerson.PersonID = SecondaryMedicationChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryMedicationChangeType ON SecondaryMedicationChangeType.AuditLogTypeID = SecondaryMedication.AuditLogTypeID
	LEFT JOIN vwAuditTrailMedication  MedicationList ON MedicationList.MedicationID = SecondaryMedication.MedicationID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	SecondaryMedication.CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND SecondaryMedication.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN SecondaryMedication.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	SecondaryMedicationChangePerson.PersonFirst + ' ' + SecondaryMedicationChangePerson.PersonLast AS 'ChangeUser',
	SecondaryMedicationChangeType.AuditLogTypeName AS 'ChangeType',
	NULL AS 'MedicationName'
FROM
	[Call]
	JOIN SecondaryMedication ON SecondaryMedication.CallID = [Call].CallID
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryMedicationChangeEmployee ON SecondaryMedicationChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson SecondaryMedicationChangePerson ON SecondaryMedicationChangePerson.PersonID = SecondaryMedicationChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryMedicationChangeType ON SecondaryMedicationChangeType.AuditLogTypeID = [Call].AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND [Call].AuditLogTypeID = 4 -- Deleted
AND	[Call].CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND [Call].CallSaveLastByID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Call].CallSaveLastByID
			ELSE @CoordinatorID
		END;

/* Final Results */
SELECT *
FROM #MedInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[MedicationName] IS NOT NULL
	)
AND	ChangeDT >= 
		CASE
			WHEN @ChangeStartDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeStartDateTime
		END
AND	ChangeDT <=
		CASE
			WHEN @ChangeEndDateTime IS NULL
			THEN ChangeDT
			ELSE @ChangeEndDateTime
		END;


DROP TABLE IF EXISTS #MedInfo;