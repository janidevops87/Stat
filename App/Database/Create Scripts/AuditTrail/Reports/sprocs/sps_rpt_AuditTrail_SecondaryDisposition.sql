IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_SecondaryDisposition')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_SecondaryDisposition';
		DROP  PROCEDURE  sps_rpt_AuditTrail_SecondaryDisposition;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_SecondaryDisposition';
GO
CREATE PROCEDURE sps_rpt_AuditTrail_SecondaryDisposition
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_SecondaryDisposition.sql
**		Name: sps_rpt_AuditTrail_SecondaryDisposition
**		Desc: 
**
**		Return values:
**
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 08/08/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		08/08/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/29/2008		ccarroll				Added ILB functionality
**		06/30/2008		ccarroll				Added Sub_Precedence for displaying Case Order sequence
**		11/05/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #DispoInfo;

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
/* SecondaryDisposition * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, SecondaryDisposition.LastModified, @DisplayMT) AS smalldatetime) AS 'ChangeDT',			
	SecondaryDispositionChangePerson.PersonFirst + ' ' + SecondaryDispositionChangePerson.PersonLast AS 'ChangeUser',
	SecondaryDispositionChangeType.AuditLogTypeName AS 'ChangeType',
	CASE WHEN SecondaryDisposition.SubCriteriaID = -2 THEN 'ILB' ELSE DynamicDonorCategory.DynamicDonorCategoryName END AS 'DonorCategory',
	CASE WHEN SecondaryDisposition.SubCriteriaID = -2 THEN 'ILB' ELSE SubType.SubTypeName END AS 'SubCategory',
	CASE WHEN SecondaryDisposition.SubCriteriaID = -2 THEN 'ILB' ELSE Organization.OrganizationName END AS 'ProcessorName',
	CASE WHEN SecondaryDisposition.SecondaryDispositionAppropriate = -2 THEN 'ILB' ELSE FSAppropriate.FSAppropriateName END AS 'Appropriate',
	CASE WHEN SecondaryDisposition.SecondaryDispositionApproach = -2 THEN 'ILB' ELSE FSApproach.FSApproachReportName END AS 'Approach',
	CASE WHEN SecondaryDisposition.SecondaryDispositionConsent = -2 THEN 'ILB' ELSE FSConsent.FSConsentReportName END AS 'Consent',
	CASE WHEN SecondaryDisposition.SecondaryDispositionConversion = -2 THEN 'ILB' ELSE FSConversion.FSConversionReportName END AS 'Recovery'
INTO #DispoInfo
FROM
	SecondaryDisposition
/* Primary table Joins */
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = SecondaryDisposition.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee SecondaryDispositionChangeEmployee ON SecondaryDispositionChangeEmployee.StatEmployeeID = SecondaryDisposition.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson SecondaryDispositionChangePerson ON SecondaryDispositionChangePerson.PersonID = SecondaryDispositionChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType SecondaryDispositionChangeType ON SecondaryDispositionChangeType.AuditLogTypeID = SecondaryDisposition.AuditLogTypeID
/* Disposition lookups */
	LEFT JOIN vwAuditTrailSubCriteria SubCriteria ON SubCriteria.SubCriteriaID = SecondaryDisposition.SubCriteriaID
	LEFT JOIN vwAuditTrailCriteria Criteria ON Criteria.CriteriaID = SubCriteria.CriteriaID
	LEFT JOIN vwAuditTrailOrganization Organization ON Organization.OrganizationID = SubCriteria.ProcessorID
	LEFT JOIN vwAuditTrailDynamicDonorCategory DynamicDonorCategory ON DynamicDonorCategory.DynamicDonorCategoryID = Criteria.DynamicDonorCategoryID
	LEFT JOIN vwAuditTrailSubType SubType ON SubType.SubTypeID = SubCriteria.SubTypeID
/* ccarroll 06/30/2008 - Added to gain sub category precedence, see order by */
	LEFT JOIN vwAuditTrailCriteriaSubType CriteriaSubType ON CriteriaSubType.CriteriaID = SubCriteria.CriteriaID and SubCriteria.SubTypeID = CriteriaSubType.SubTypeID
	LEFT JOIN vwAuditTrailFSAppropriate FSAppropriate ON FSAppropriate.FSAppropriateID = SecondaryDisposition.SecondaryDispositionAppropriate
	LEFT JOIN vwAuditTrailFSApproach FSApproach ON FSApproach.FSApproachID = SecondaryDisposition.SecondaryDispositionApproach
	LEFT JOIN vwAuditTrailFSConsent FSConsent ON FSConsent.FSConsentID = SecondaryDisposition.SecondaryDispositionConsent
	LEFT JOIN vwAuditTrailFSConversion FSConversion ON FSConversion.FSConversionID = SecondaryDisposition.SecondaryDispositionConversion
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	SecondaryDisposition.CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND SecondaryDisposition.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN SecondaryDisposition.LastStatEmployeeID
			ELSE @CoordinatorID
		END


SELECT *
FROM #DispoInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[DonorCategory] IS NOT NULL
	OR	[SubCategory] IS NOT NULL
	OR	[ProcessorName] IS NOT NULL
	OR	[Appropriate] IS NOT NULL
	OR	[Approach] IS NOT NULL
	OR	[Consent] IS NOT NULL
	OR	[Recovery] IS NOT NULL
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


DROP TABLE IF EXISTS #DispoInfo;