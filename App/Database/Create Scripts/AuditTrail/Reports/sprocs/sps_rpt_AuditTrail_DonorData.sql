IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_DonorData')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_DonorData';
		DROP  PROCEDURE  sps_rpt_AuditTrail_DonorData;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_DonorData';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_DonorData 
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_DonorData.sql
**		Name: sps_rpt_AuditTrail_DonorData
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
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
**      07/26/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality in update sproc
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #DonorData;


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
/*** DonorData *** - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, DonorData.LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',
	DonorDataChangePerson.PersonFirst + ' ' + DonorDataChangePerson.PersonLast AS 'ChangeUser',
	DonorDataChangeType.AuditLogTypeName AS 'ChangeType',
/* Donor Data */
	DonorData.DonorDataMiddleName,
	DonorData.DonorDataLicense,
	DonorData.DonorDataAddress,
	DonorData.DonorDataCity,
	DonorData.DonorDataState,
	DonorData.DonorDataZip,
	CASE DonorData.DonorDataNotAvailable
		WHEN 1
		THEN 'Yes'
		ELSE 'No'
	END AS 'DonorDataNotAvailable'
INTO #DonorData
FROM
	DonorData 
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = DonorData.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* DonorData */
	LEFT JOIN vwAuditTrailStatEmployee DonorDataChangeEmployee ON DonorDataChangeEmployee.StatEmployeeID = DonorData.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson DonorDataChangePerson ON DonorDataChangePerson.PersonID = DonorDataChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType DonorDataChangeType ON DonorDataChangeType.AuditLogTypeID = DonorData.AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	DonorData.CallID = @CallID
AND DonorData.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN DonorData.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT DISTINCT
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	DonorDataChangePerson.PersonFirst + ' ' + DonorDataChangePerson.PersonLast AS 'ChangeUser',
	DonorDataChangeType.AuditLogTypeName AS 'ChangeType',
/* Donor Data */
	NULL AS 'DonorDataMiddleName',
	NULL AS 'DonorDataLicense',
	NULL AS 'DonorDataAddress',
	NULL AS 'DonorDataCity',
	NULL AS 'DonorDataState',
	NULL AS 'DonorDataZip',
	NULL AS 'DonorDataNotAvailable'
FROM Call
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* DonorData */
	LEFT JOIN vwAuditTrailStatEmployee DonorDataChangeEmployee ON DonorDataChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID
	LEFT JOIN vwAuditTrailPerson DonorDataChangePerson ON DonorDataChangePerson.PersonID = DonorDataChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType DonorDataChangeType ON DonorDataChangeType.AuditLogTypeID = [Call].AuditLogTypeID
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

/* Final DonorData */
SELECT *
FROM #DonorData
WHERE
	(
		ChangeType = 'Delete'
	OR	[DonorDataMiddleName] IS NOT NULL
	OR	[DonorDataLicense] IS NOT NULL
	OR	[DonorDataAddress] IS NOT NULL
	OR	[DonorDataCity] IS NOT NULL
	OR	[DonorDataState] IS NOT NULL
	OR	[DonorDataZip] IS NOT NULL
	OR	[DonorDataNotAvailable] IS NOT NULL
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


DROP TABLE IF EXISTS #DonorData;