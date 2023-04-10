IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_NOK')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_NOK';
		DROP  PROCEDURE  sps_rpt_AuditTrail_NOK;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_NOK';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_NOK
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_NOK.sql
**		Name: sps_rpt_AuditTrail_NOK
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
**		Date: 07/23/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		--------		--------				-------------------------------------------
**		07/23/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/28/2008		ccarroll				Added ILB functionality
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #NOKInfo;


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
/*** NOK *** - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, NOK.LastModified, @DisplayMT)AS smalldatetime) AS 'ChangeDT',
	NOKChangePerson.PersonFirst + ' ' + NOKChangePerson.PersonLast AS 'ChangeUser',
	NOKChangeType.AuditLogTypeName AS 'ChangeType',
/* Next of Kin Information */
	NOK.NOKFirstName AS 'ReferralNOKFirstName',
	NOK.NOKLastName AS 'ReferralNOKLastName',
	NOK.NOKApproachRelation AS 'ReferralNOKApproachRelation',
	NOK.NOKPhone AS 'ReferralNOKPhone',
	NOK.NOKAddress AS 'ReferralNOKAddress',
	NOK.NOKCity AS 'ReferralNOKCity',
	CASE WHEN NOK.NOKStateID = -2 THEN 'ILB' ELSE NOKState.StateAbbrv END AS 'ReferralNOKState',
	NOK.NOKZip AS 'ReferralNOKZip'
INTO #NOKInfo
FROM
	NOK
	JOIN vwAuditTrailReferral  RefReferral ON RefReferral.ReferralNOKID = NOK.NOKID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* NOK */
	LEFT JOIN vwAuditTrailState NOKState ON NOKState.StateID = NOK.NOKStateID 
	LEFT JOIN vwAuditTrailStatEmployee NOKChangeEmployee ON NOKChangeEmployee.StatEmployeeID = NOK.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson NOKChangePerson ON NOKChangePerson.PersonID = NOKChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType NOKChangeType ON NOKChangeType.AuditLogTypeID = NOK.AuditLogTypeID
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	RefReferral.CallID = @CallID
AND NOK.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN NOK.LastStatEmployeeID
			ELSE @CoordinatorID
		END

UNION ALL /*** Deleted Calls ***/

SELECT DISTINCT 
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	NOKChangePerson.PersonFirst + ' ' +NOKChangePerson.PersonLast AS 'ChangeUser',
	NOKChangeType.AuditLogTypeName AS 'ChangeType',
/* Next of Kin Information */
	NULL AS 'ReferralNOKFirstName',
	NULL AS 'ReferralNOKLastName',
	NULL AS 'ReferralNOKApproachRelation',
	NULL AS 'ReferralNOKPhone',
	NULL AS 'ReferralNOKAddress',
	NULL AS 'ReferralNOKCity',
	NULL AS 'ReferralNOKState',
	NULL AS 'ReferralNOKZip'
FROM
	[Call]
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	LEFT JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
	LEFT JOIN vwAuditTrailStatEmployee NOKChangeEmployee ON NOKChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson NOKChangePerson ON NOKChangePerson.PersonID = NOKChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType NOKChangeType ON NOKChangeType.AuditLogTypeID = [Call].AuditLogTypeID
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
FROM #NOKInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	ReferralNOKFirstName IS NOT NULL
	OR	ReferralNOKLastName IS NOT NULL
	OR	ReferralNOKApproachRelation IS NOT NULL
	OR	ReferralNOKPhone IS NOT NULL
	OR	ReferralNOKAddress IS NOT NULL
	OR	ReferralNOKCity IS NOT NULL
	OR	ReferralNOKState IS NOT NULL
	OR	ReferralNOKZip IS NOT NULL
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

DROP TABLE IF EXISTS #NOKInfo;