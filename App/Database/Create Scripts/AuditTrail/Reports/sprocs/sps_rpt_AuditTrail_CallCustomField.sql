IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_CallCustomField')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_CallCustomField';
		DROP  PROCEDURE  sps_rpt_AuditTrail_CallCustomField;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_CallCustomField';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_CallCustomField
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_CallCustomField.sql
**		Name: sps_rpt_AuditTrail_CallCustomField
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input								Output
**     ----------							-----------
**	   See above
**
**		Auth: christopher carroll
**		Date: 07/26/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**      07/27/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality to Update sproc
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT 
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #CustomInfo;


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
/*** CallCustomField *** - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, CallCustomField.LastModified, @DisplayMT) AS smalldatetime)AS 'ChangeDT',
	CallCustomFieldChangePerson.PersonFirst + ' ' + CallCustomFieldChangePerson.PersonLast AS 'ChangeUser',
	CallCustomFieldChangeType.AuditLogTypeName AS 'ChangeType',
/* More Data */
	CallCustomField.CallCustomField1 AS 'Label 1',
	CallCustomField.CallCustomField2 AS 'Label 2',
	CallCustomField.CallCustomField3 AS 'Label 3',
	CallCustomField.CallCustomField4 AS 'Label 4',
	CallCustomField.CallCustomField5 AS 'Label 5',
	CallCustomField.CallCustomField6 AS 'Label 6',
	CallCustomField.CallCustomField7 AS 'Label 7',
	CallCustomField.CallCustomField8 AS 'Label 8',
/* More Data Cont.. */
	CallCustomField.CallCustomField9 AS 'Label 9',
	CallCustomField.CallCustomField10 AS 'Label 10',
	CallCustomField.CallCustomField11 AS 'Label 11',
	CallCustomField.CallCustomField12 AS 'Label 12',
	CallCustomField.CallCustomField13 AS 'Label 13',
	CallCustomField.CallCustomField14 AS 'Label 14',
	CallCustomField.CallCustomField15 AS 'Label 15',
	CallCustomField.CallCustomField16 AS 'Label 16'
INTO #CustomInfo
FROM 
	CallCustomField
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = CallCustomField.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* CallCustomField */
	LEFT JOIN vwAuditTrailStatEmployee CallCustomFieldChangeEmployee ON CallCustomFieldChangeEmployee.StatEmployeeID = CallCustomField.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson CallCustomFieldChangePerson ON CallCustomFieldChangePerson.PersonID = CallCustomFieldChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType CallCustomFieldChangeType ON CallCustomFieldChangeType.AuditLogTypeID = CallCustomField.AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	CallCustomField.CallID = @CallID
AND CallCustomField.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN CallCustomField.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL

SELECT DISTINCT /*** Deleted Calls ***/
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	CallCustomFieldChangePerson.PersonFirst + ' ' + CallCustomFieldChangePerson.PersonLast AS 'ChangeUser',
	CallCustomFieldChangeType.AuditLogTypeName AS 'ChangeType',
/* More Data */
	NULL AS 'Label 1',
	NULL AS 'Label 2',
	NULL AS 'Label 3',
	NULL AS 'Label 4',
	NULL AS 'Label 5',
	NULL AS 'Label 6',
	NULL AS 'Label 7',
	NULL AS 'Label 8',
/* More Data Cont.. */
	NULL AS 'Label 9',
	NULL AS 'Label 10',
	NULL AS 'Label 11',
	NULL AS 'Label 12',
	NULL AS 'Label 13',
	NULL AS 'Label 14',
	NULL AS 'Label 15',
	NULL AS 'Label 16'
FROM
	[Call]
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* CallCustomField */
	LEFT JOIN vwAuditTrailStatEmployee CallCustomFieldChangeEmployee ON CallCustomFieldChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson CallCustomFieldChangePerson ON CallCustomFieldChangePerson.PersonID = CallCustomFieldChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType CallCustomFieldChangeType ON CallCustomFieldChangeType.AuditLogTypeID = [Call].AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND [Call].AuditLogTypeID = 4 -- Deleted
AND	[Call].CallID = @CallID
AND [Call].CallSaveLastByID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN [Call].CallSaveLastByID
			ELSE @CoordinatorID
		END;


/* Final Results */
SELECT *
FROM #CustomInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[Label 1] IS NOT NULL
	OR	[Label 2] IS NOT NULL
	OR	[Label 3] IS NOT NULL
	OR	[Label 4] IS NOT NULL
	OR	[Label 5] IS NOT NULL
	OR	[Label 6] IS NOT NULL
	OR	[Label 7] IS NOT NULL
	OR	[Label 8] IS NOT NULL
	OR	[Label 9] IS NOT NULL
	OR	[Label 10] IS NOT NULL
	OR	[Label 11] IS NOT NULL
	OR	[Label 12] IS NOT NULL
	OR	[Label 13] IS NOT NULL
	OR	[Label 14] IS NOT NULL
	OR	[Label 15] IS NOT NULL
	OR	[Label 16] IS NOT NULL
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

DROP TABLE IF EXISTS #CustomInfo;