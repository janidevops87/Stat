IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Secondary2')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_Secondary2';
		DROP  Procedure  sps_rpt_AuditTrail_Secondary2;
	END
GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Secondary2';
GO
CREATE Procedure sps_rpt_AuditTrail_Secondary2
	@CallID					int,
	@ReportGroupID			int,
	@ChangeStartDateTime	datetime	= NULL,
	@ChangeEndDateTime		datetime	= NULL,
	@CoordinatorID			int			= NULL,
	@UserOrgID				int			= NULL,
	@DisplayMT				int			= NULL
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Secondary2.sql
**		Name: sps_rpt_AuditTrail_Secondary2
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
**		Date: 08/07/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      08/07/2007		ccarroll				initial
**		08/31/2007		ccarroll				Check for matching Start-End datetime
**		05/29/2008		ccarroll				Added ILB functionality
**		11/04/2008		ccarroll				Added DisplayMT to ChangeDT, Updated reference data to views
**		11/24/2008		ccarroll				Added rounding to ChangeDT
**		10/28/2020		James Gerberich			Refactored for performance. VS 69284
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
DROP TABLE IF EXISTS #SecondaryInfo;
DROP TABLE IF EXISTS #TempBloodProductILB;
DROP TABLE IF EXISTS #TempCultureILB;


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

/* Create Temp lookup table For Blood Product 
	and add ILB */
SELECT BloodProductId, BloodProductName
INTO #TempBloodProductILB
FROM vwAuditTrailBloodProduct
UNION
SELECT -2, 'ILB';

/* Create Temp lookup table For Culture 
	and add ILB */
SELECT CultureId, CultureName
INTO #TempCultureILB
FROM vwAuditTrailCulture
UNION
SELECT -2, 'ILB';


SELECT DISTINCT
/* Secondary2 * - User Change Data */
	CAST(dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, Secondary2.LastModified, @DisplayMT) AS smalldatetime)AS 'ChangeDT',
	Secondary2ChangePerson.PersonFirst + ' ' + Secondary2ChangePerson.PersonLast AS 'ChangeUser',
	Secondary2ChangeType.AuditLogTypeName AS 'ChangeType',
/* Blood Products */
	BloodProduct1.BloodProductName AS 'Product1Type',
	Secondary2.SecondaryBloodProductsReceived1Units,
	Secondary2.SecondaryBloodProductsReceived1TypeCC,
	Secondary2.SecondaryBloodProductsReceived1TypeUnitGiven,
	BloodProduct2.BloodProductName AS 'Product2Type',
	Secondary2.SecondaryBloodProductsReceived2Units,
	Secondary2.SecondaryBloodProductsReceived2TypeCC,
	Secondary2.SecondaryBloodProductsReceived2TypeUnitGiven,
	BloodProduct3.BloodProductName AS 'Product3Type',
	Secondary2.SecondaryBloodProductsReceived3Units,
	Secondary2.SecondaryBloodProductsReceived3TypeCC,
	Secondary2.SecondaryBloodProductsReceived3TypeUnitGiven,
/* Colloids */
	ColloidsInfused1.BloodProductName AS 'ColloidsInfused1Type',
	Secondary2.SecondaryColloidsInfused1Units,
	Secondary2.SecondaryColloidsInfused1CC,
	Secondary2.SecondaryColloidsInfused1UnitGiven,
	ColloidsInfused2.BloodProductName AS 'ColloidsInfused2Type',
	Secondary2.SecondaryColloidsInfused2Units,
	Secondary2.SecondaryColloidsInfused2CC,
	Secondary2.SecondaryColloidsInfused2UnitGiven,
	ColloidsInfused3.BloodProductName AS 'ColloidsInfused3Type',
	Secondary2.SecondaryColloidsInfused3Units,
	Secondary2.SecondaryColloidsInfused3CC,
	Secondary2.SecondaryColloidsInfused3UnitGiven,
/* Crystalloids */
	Crystalloids1.BloodProductName AS 'Crystalloids1Type',
	Secondary2.SecondaryCrystalloids1Units,
	Secondary2.SecondaryCrystalloids1CC,
	Secondary2.SecondaryCrystalloids1UnitGiven,
	Crystalloids2.BloodProductName AS 'Crystalloids2Type',
	Secondary2.SecondaryCrystalloids2Units,
	Secondary2.SecondaryCrystalloids2CC,
	Secondary2.SecondaryCrystalloids2UnitGiven,
	Crystalloids3.BloodProductName AS 'Crystalloids3Type',
	Secondary2.SecondaryCrystalloids3Units,
	Secondary2.SecondaryCrystalloids3CC,
	Secondary2.SecondaryCrystalloids3UnitGiven,
/* WBC */
	Secondary2.SecondaryWBC1,
	CONVERT(varchar, Secondary2.SecondaryWBC1Date,101) AS 'SecondaryWBC1Date',
	Secondary2.SecondaryWBC1Bands,
	Secondary2.SecondaryWBC2,
	CONVERT(varchar, Secondary2.SecondaryWBC2Date,101) AS 'SecondaryWBC2Date',
	Secondary2.SecondaryWBC2Bands,
	Secondary2.SecondaryWBC3,
	CONVERT(varchar, Secondary2.SecondaryWBC3Date,101) AS 'SecondaryWBC3Date',
	Secondary2.SecondaryWBC3Bands,
/* Lab Temp */
	CASE WHEN Secondary2.SecondaryLabTemp1Date = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, Secondary2.SecondaryLabTemp1Date,101) END AS 'Temp1Date',
	Secondary2.SecondaryLabTemp1Time AS 'Temp1Time',
	Secondary2.SecondaryLabTemp1 AS 'Temp1',
	CASE WHEN Secondary2.SecondaryLabTemp2Date = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, Secondary2.SecondaryLabTemp2Date,101) END AS 'Temp2Date',
	Secondary2.SecondaryLabTemp2Time AS 'Temp2Time',
	Secondary2.SecondaryLabTemp2 AS 'Temp2',
	CASE WHEN Secondary2.SecondaryLabTemp3Date = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, Secondary2.SecondaryLabTemp3Date,101) END AS 'Temp3Date',
	Secondary2.SecondaryLabTemp3Time AS 'Temp3Time',
	Secondary2.SecondaryLabTemp3 AS 'Temp3',
/* Culture */
	Culture1.CultureName AS 'Culture1Type',
	CASE WHEN Secondary2.SecondaryCulture1DrawnDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryCulture1DrawnDate, 101) END AS 'Culture1DateDrawn',
	CASE WHEN Secondary2.SecondaryCulture1Growth = '01/01/1900' THEN 'ILB' ELSE SecondaryCulture1Growth END AS 'Culture1GrowthtoDate',
	Culture2.CultureName AS 'Culture2Type',
	CASE WHEN Secondary2.SecondaryCulture2DrawnDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryCulture2DrawnDate, 101) END AS 'Culture2DateDrawn',
	CASE WHEN Secondary2.SecondaryCulture2Growth = '01/01/1900' THEN 'ILB' ELSE SecondaryCulture2Growth END AS 'Culture2GrowthtoDate',
	Culture3.CultureName AS 'Culture3Type',
	CASE WHEN Secondary2.SecondaryCulture3DrawnDate = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryCulture3DrawnDate, 101) END AS 'Culture3DateDrawn',
	CASE WHEN Secondary2.SecondaryCulture3Growth = '01/01/1900' THEN 'ILB' ELSE SecondaryCulture3Growth END AS 'Culture3GrowthtoDate',
/* CXR */
	CASE WHEN Secondary2.SecondaryCXRAvailable = -2 THEN 'ILB' ELSE YNCXRAvailable.YesNoNa_RefName END AS 'CXRAvailable',
	CASE WHEN Secondary2.SecondaryCXR1Date = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryCXR1Date,101) END AS 'CXR1Date',
	SecondaryCXR1Finding AS 'CRX1Findings',
	CASE WHEN Secondary2.SecondaryCXR2Date = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryCXR2Date,101) END AS 'CXR2Date',
	SecondaryCXR2Finding AS 'CRX2Findings',
	CASE WHEN Secondary2.SecondaryCXR3Date = '01/01/1900' THEN 'ILB' ELSE CONVERT(varchar, SecondaryCXR3Date,101) END AS 'CXR3Date',
	SecondaryCXR3Finding AS 'CRX3Findings'
INTO #SecondaryInfo
FROM Secondary2
/* Primary table Joins */
	JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = Secondary2.CallID
	JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee Secondary2ChangeEmployee ON Secondary2ChangeEmployee.StatEmployeeID = Secondary2.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson Secondary2ChangePerson ON Secondary2ChangePerson.PersonID = Secondary2ChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType Secondary2ChangeType ON Secondary2ChangeType.AuditLogTypeID = Secondary2.AuditLogTypeID
/* Blood Products */
	LEFT JOIN #TempBloodProductILB AS BloodProduct1 ON BloodProduct1.BloodProductId = Secondary2.SecondaryBloodProductsReceived1Type
	LEFT JOIN #TempBloodProductILB AS BloodProduct2 ON BloodProduct2.BloodProductId = Secondary2.SecondaryBloodProductsReceived2Type
	LEFT JOIN #TempBloodProductILB AS BloodProduct3 ON BloodProduct3.BloodProductId = Secondary2.SecondaryBloodProductsReceived3Type
/* Colloids */
	LEFT JOIN #TempBloodProductILB AS ColloidsInfused1 ON ColloidsInfused1.BloodProductId = Secondary2.SecondaryColloidsInfused1Type
	LEFT JOIN #TempBloodProductILB AS ColloidsInfused2 ON ColloidsInfused2.BloodProductId = Secondary2.SecondaryColloidsInfused2Type
	LEFT JOIN #TempBloodProductILB AS ColloidsInfused3 ON ColloidsInfused3.BloodProductId = Secondary2.SecondaryColloidsInfused3Type
/* Crystalloids */
	LEFT JOIN #TempBloodProductILB AS Crystalloids1 ON Crystalloids1.BloodProductId = Secondary2.SecondaryCrystalloids1Type
	LEFT JOIN #TempBloodProductILB AS Crystalloids2 ON Crystalloids2.BloodProductId = Secondary2.SecondaryCrystalloids2Type
	LEFT JOIN #TempBloodProductILB AS Crystalloids3 ON Crystalloids3.BloodProductId = Secondary2.SecondaryCrystalloids3Type
/* Culture */
	LEFT JOIN #TempCultureILB AS Culture1 ON Culture1.CultureId = Secondary2.SecondaryCulture1Type
	LEFT JOIN #TempCultureILB AS Culture2 ON Culture2.CultureId = Secondary2.SecondaryCulture2Type
	LEFT JOIN #TempCultureILB AS Culture3 ON Culture3.CultureId = Secondary2.SecondaryCulture3Type
/* Yes No NA lookups */
	LEFT JOIN vwAuditTrailYesNoNa_Ref	 AS YNCXRAvailable ON YNCXRAvailable.YesNoNa_RefID = Secondary2.SecondaryCXRAvailable
WHERE
	WebRGO.WebReportGroupID = @ReportGroupID
AND	Secondary2.CallID = 
		CASE
			WHEN @CallID IS NULL
			THEN -1
			ELSE @CallID
		END
AND Secondary2.LastStatEmployeeID =
		CASE
			WHEN @CoordinatorID IS NULL
			THEN Secondary2.LastStatEmployeeID
			ELSE @CoordinatorID
		END
UNION ALL /*** Deleted Calls ***/
SELECT
	dbo.AuditTrailfn_rpt_ConvertDateTime(RefReferral.ReferralCallerOrganizationID, [Call].LastModified, @DisplayMT) AS 'ChangeDT',
	Secondary2ChangePerson.PersonFirst + ' ' + Secondary2ChangePerson.PersonLast AS 'ChangeUser',
	Secondary2ChangeType.AuditLogTypeName AS 'ChangeType',
/* Blood Products */
	NULL AS 'Product1Type',
	NULL AS 'SecondaryBloodProductsReceived1Units',
	NULL AS 'SecondaryBloodProductsReceived1TypeCC',
	NULL AS 'SecondaryBloodProductsReceived1TypeUnitGiven',
	NULL AS 'Product2Type',
	NULL AS 'SecondaryBloodProductsReceived2Units',
	NULL AS 'SecondaryBloodProductsReceived2TypeCC',
	NULL AS 'SecondaryBloodProductsReceived2TypeUnitGiven',
	NULL AS 'Product3Type',
	NULL AS 'SecondaryBloodProductsReceived3Units',
	NULL AS 'SecondaryBloodProductsReceived3TypeCC',
	NULL AS 'SecondaryBloodProductsReceived3TypeUnitGiven',
/* Colloids */
	NULL AS 'ColloidsInfused1Type',
	NULL AS 'SecondaryColloidsInfused1Units',
	NULL AS 'SecondaryColloidsInfused1CC',
	NULL AS 'SecondaryColloidsInfused1UnitGiven',
	NULL AS 'ColloidsInfused2Type',
	NULL AS 'SecondaryColloidsInfused2Units',
	NULL AS 'SecondaryColloidsInfused2CC',
	NULL AS 'SecondaryColloidsInfused2UnitGiven',
	NULL AS 'ColloidsInfused3Type',
	NULL AS 'SecondaryColloidsInfused3Units',
	NULL AS 'SecondaryColloidsInfused3CC',
	NULL AS 'SecondaryColloidsInfused3UnitGiven',
/* Crystalloids */
	NULL AS 'Crystalloids1Type',
	NULL AS 'SecondaryCrystalloids1Units',
	NULL AS 'SecondaryCrystalloids1CC',
	NULL AS 'SecondaryCrystalloids1UnitGiven',
	NULL AS 'Crystalloids2Type',
	NULL AS 'SecondaryCrystalloids2Units',
	NULL AS 'SecondaryCrystalloids2CC',
	NULL AS 'SecondaryCrystalloids2UnitGiven',
	NULL AS 'Crystalloids3Type',
	NULL AS 'SecondaryCrystalloids3Units',
	NULL AS 'SecondaryCrystalloids3CC',
	NULL AS 'SecondaryCrystalloids3UnitGiven',
/* WBC */
	NULL AS 'SecondaryWBC1',
	NULL AS 'SecondaryWBC1Date',
	NULL AS 'SecondaryWBC1Bands',
	NULL AS 'SecondaryWBC2',
	NULL AS 'SecondaryWBC2Date',
	NULL AS 'SecondaryWBC2Bands',
	NULL AS 'SecondaryWBC3',
	NULL AS 'SecondaryWBC3Date',
	NULL AS 'SecondaryWBC3Bands',
/* Lab Temp */
	NULL AS 'Temp1Date',
	NULL AS 'Temp1Time',
	NULL AS 'Temp1',
	NULL AS 'Temp2Date',
	NULL AS 'Temp2Time',
	NULL AS 'Temp2',
	NULL AS 'Temp3Date',
	NULL AS 'Temp3Time',
	NULL AS 'Temp3',
/* Culture */
	NULL AS 'Culture1Type',
	NULL AS 'Culture1DateDrawn',
	NULL AS 'Culture1GrowthtoDate',
	NULL AS 'Culture2Type',
	NULL AS 'Culture2DateDrawn',
	NULL AS 'Culture2GrowthtoDate',
	NULL AS 'Culture3Type',
	NULL AS 'Culture3DateDrawn',
	NULL AS 'Culture3GrowthtoDate',
/* CXR */
	NULL AS 'CXRAvailable',
	NULL AS 'CXR1Date',
	NULL AS 'CRX1Findings',
	NULL AS 'CXR2Date',
	NULL AS 'CRX2Findings',
	NULL AS 'CXR3Date',
	NULL AS 'CRX3Findings'
FROM
	[Call]
	JOIN Secondary2 ON Secondary2.CallID = [Call].CallID
/* Primary table Joins */
	LEFT JOIN vwAuditTrailReferral RefReferral ON RefReferral.CallID = [Call].CallID
	LEFT JOIN vwAuditTrailWebReportGroupOrg WebRGO ON WebRGO.OrganizationID = RefReferral.ReferralCallerOrganizationID 
/* Secondary Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee Secondary2ChangeEmployee ON Secondary2ChangeEmployee.StatEmployeeID = [Call].CallSaveLastByID 
	LEFT JOIN vwAuditTrailPerson Secondary2ChangePerson ON Secondary2ChangePerson.PersonID = Secondary2ChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType Secondary2ChangeType ON Secondary2ChangeType.AuditLogTypeID = [Call].AuditLogTypeID
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
FROM #SecondaryInfo
WHERE
	(
		ChangeType = 'Delete'
	OR	[Product1Type] IS NOT NULL
	OR	[SecondaryBloodProductsReceived1Units] IS NOT NULL
	OR	[SecondaryBloodProductsReceived1TypeCC] IS NOT NULL
	OR	[SecondaryBloodProductsReceived1TypeUnitGiven] IS NOT NULL
	OR	[Product2Type] IS NOT NULL
	OR	[SecondaryBloodProductsReceived2Units] IS NOT NULL
	OR	[SecondaryBloodProductsReceived2TypeCC] IS NOT NULL
	OR	[SecondaryBloodProductsReceived2TypeUnitGiven] IS NOT NULL
	OR	[Product3Type] IS NOT NULL
	OR	[SecondaryBloodProductsReceived3Units] IS NOT NULL
	OR	[SecondaryBloodProductsReceived3TypeCC] IS NOT NULL
	OR	[SecondaryBloodProductsReceived3TypeUnitGiven] IS NOT NULL
	OR	[ColloidsInfused1Type] IS NOT NULL
	OR	[SecondaryColloidsInfused1Units] IS NOT NULL
	OR	[SecondaryColloidsInfused1CC] IS NOT NULL
	OR	[SecondaryColloidsInfused1UnitGiven] IS NOT NULL
	OR	[ColloidsInfused2Type] IS NOT NULL
	OR	[SecondaryColloidsInfused2Units] IS NOT NULL
	OR	[SecondaryColloidsInfused2CC] IS NOT NULL
	OR	[SecondaryColloidsInfused2UnitGiven] IS NOT NULL
	OR	[ColloidsInfused3Type] IS NOT NULL
	OR	[SecondaryColloidsInfused3Units] IS NOT NULL
	OR	[SecondaryColloidsInfused3CC] IS NOT NULL
	OR	[SecondaryColloidsInfused3UnitGiven] IS NOT NULL
	OR	[Crystalloids1Type] IS NOT NULL
	OR	[SecondaryCrystalloids1Units] IS NOT NULL
	OR	[SecondaryCrystalloids1CC] IS NOT NULL
	OR	[SecondaryCrystalloids1UnitGiven] IS NOT NULL
	OR	[Crystalloids2Type] IS NOT NULL
	OR	[SecondaryCrystalloids2Units] IS NOT NULL
	OR	[SecondaryCrystalloids2CC] IS NOT NULL
	OR	[SecondaryCrystalloids2UnitGiven] IS NOT NULL
	OR	[Crystalloids3Type] IS NOT NULL
	OR	[SecondaryCrystalloids3Units] IS NOT NULL
	OR	[SecondaryCrystalloids3CC] IS NOT NULL
	OR	[SecondaryCrystalloids3UnitGiven] IS NOT NULL
	OR	[SecondaryWBC1] IS NOT NULL
	OR	[SecondaryWBC1Date] IS NOT NULL
	OR	[SecondaryWBC1Bands] IS NOT NULL
	OR	[SecondaryWBC2] IS NOT NULL
	OR	[SecondaryWBC2Date] IS NOT NULL
	OR	[SecondaryWBC2Bands] IS NOT NULL
	OR	[SecondaryWBC3] IS NOT NULL
	OR	[SecondaryWBC3Date] IS NOT NULL
	OR	[SecondaryWBC3Bands] IS NOT NULL
	OR	[Temp1Date] IS NOT NULL
	OR	[Temp1Time] IS NOT NULL
	OR	[Temp1] IS NOT NULL
	OR	[Temp2Date] IS NOT NULL
	OR	[Temp2Time] IS NOT NULL
	OR	[Temp2] IS NOT NULL
	OR	[Temp3Date] IS NOT NULL
	OR	[Temp3Time] IS NOT NULL
	OR	[Temp3] IS NOT NULL
	OR	[Culture1Type] IS NOT NULL
	OR	[Culture1DateDrawn] IS NOT NULL
	OR	[Culture1GrowthtoDate] IS NOT NULL
	OR	[Culture2Type] IS NOT NULL
	OR	[Culture2DateDrawn] IS NOT NULL
	OR	[Culture2GrowthtoDate] IS NOT NULL
	OR	[Culture3Type] IS NOT NULL
	OR	[Culture3DateDrawn] IS NOT NULL
	OR	[Culture3GrowthtoDate] IS NOT NULL
	OR	[CXRAvailable] IS NOT NULL
	OR	[CXR1Date] IS NOT NULL
	OR	[CRX1Findings] IS NOT NULL
	OR	[CXR2Date] IS NOT NULL
	OR	[CRX2Findings] IS NOT NULL
	OR	[CXR3Date] IS NOT NULL
	OR	[CRX3Findings] IS NOT NULL	
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


DROP TABLE IF EXISTS #SecondaryInfo;
DROP TABLE IF EXISTS #TempBloodProductILB;
DROP TABLE IF EXISTS #TempCultureILB;