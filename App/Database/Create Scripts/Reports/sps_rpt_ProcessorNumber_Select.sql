IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ProcessorNumber_Select')
BEGIN
	PRINT 'Dropping Procedure sps_rpt_ProcessorNumber_Select';
	DROP PROCEDURE sps_rpt_ProcessorNumber_Select;
END
GO

PRINT 'Creating Procedure sps_rpt_ProcessorNumber_Select';
GO

CREATE Procedure sps_rpt_ProcessorNumber_Select
	@ProcessorType				VARCHAR(10)	= NULL,
	@ReferralStartDateTime		DATETIME	= NULL,
	@ReferralEndDateTime		DATETIME	= NULL,
	@ReportGroupID				INT			= NULL,
	@OrganizationID				INT			= NULL,
	@SourceCodeName				VARCHAR(10) = NULL,
	@UserOrgID					INT			= NULL,
	@DisplayMT					INT			= NULL

AS
/******************************************************************************
**		File: sps_rpt_ProcessorNumber_Select.sql
**		Name: sps_rpt_ProcessorNumber_Select
**		Desc: Shows procesor number detail for given time period.
**              
**		Return values:
** 
**		Called by: Reporting Services   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: christopher carroll  
**		Date: 09/25/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		09/25/2008		ccarroll				initial
**		01/07/2009		ccarroll				Processor Type CTDN was TBI. Parameter sent
**												from CustomParamsProcessor listitem 
**		11/5/2020		Mike Berenson			Added temp tables for performance and eliminated
**													need for sps_rpt_ProcessorNumber
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE
	@AdjustedReferralStartDateTime	SMALLDATETIME = DATEADD(HH, -4, @ReferralStartDateTime),
	@AdjustedReferralEndDateTime	SMALLDATETIME = DATEADD(HH, 4, @ReferralEndDateTime);

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedCalls;
DROP TABLE IF EXISTS #FilteredCalls;

-- Load #SourceCodes
SELECT SourceCodeID
INTO #SourceCodes
FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);

-- Load #ConvertedCalls with CallID, converted CallDT, and PatientName
SELECT 
	c.CallID,
	dbo.fn_rpt_ConvertDateTime(r.ReferralCallerOrganizationID, c.CallDateTime, @DisplayMT) AS CallDT,
	r.ReferralDonorLastName + ', ' + r.ReferralDonorFirstName + ' ' + ISNULL(r.ReferralDonorNameMI,'') AS 'PatientName'
INTO #ConvertedCalls
FROM 
	[Call] c
	JOIN #SourceCodes sc				ON c.SourceCodeID = sc.SourceCodeID
	JOIN Referral r						ON c.CallID = r.CallID
	LEFT JOIN WebReportGroupOrg wrgo	ON wrgo.OrganizationID = r.ReferralCallerOrganizationID 
WHERE	
	c.CallDateTime > @AdjustedReferralStartDateTime
	AND c.CallDateTime < @AdjustedReferralEndDateTime	
	AND (r.ReferralCallerOrganizationID = CASE WHEN @OrganizationID IS NULL THEN r.ReferralCallerOrganizationID ELSE @OrganizationID END)
	AND (wrgo.WebReportGroupID = CASE WHEN @ReportGroupID IS NULL THEN wrgo.WebReportGroupID ELSE @ReportGroupID END);

-- Load #FilteredCalls with calls filtered after date conversion
SELECT 
	CallID,
	PatientName
INTO #FilteredCalls
FROM
	#ConvertedCalls
WHERE
	CallDT > @ReferralStartDateTime
	AND CallDT < @ReferralEndDateTime;	

-- Run final select for the appropriate ProcessorType
IF @ProcessorType = 'CTDN'
BEGIN
	--TBI Processor Number
	SELECT
		st.SecondaryTBINumber AS 'ProcessorNumber',
		fc.PatientName,
		fc.CallID,
		se.StatEmployeeFirstName + ' ' + se.StatEmployeeLastName AS 'IssuedBy',
		CASE WHEN ISNULL(st.SecondaryTBIAssignmentNotNeeded, 0) = -1 THEN 'Yes' ELSE '' END AS 'AssignmentNotNeeded',
		ISNULL(st.SecondaryTBIComment, '') AS 'Comment'					 			
	FROM	
		#FilteredCalls fc		
		JOIN SecondaryTBI st		ON st.CallID = fc.CallID
		LEFT JOIN StatEmployee se	ON se.StatEmployeeID = st.SecondaryTBIIssuedStatEmployeeID;
END
ELSE IF @ProcessorType = 'CryoLife' OR @ProcessorType = 'MTF' OR @ProcessorType = 'LifeNet' 
BEGIN
	--Cryolife, MTF, or LifeNet Processor Number
	SELECT 	
		CASE WHEN @ProcessorType = 'CryoLife' THEN s.SecondaryCryolifeNumber
			WHEN @ProcessorType = 'MTF' THEN s.SecondaryMTFNumber
			WHEN @ProcessorType = 'LifeNet' THEN s.SecondaryLifeNetNumber
			END AS 'ProcessorNumber', 
		fc.PatientName,
		fc.CallID,
		'' AS 'IssuedBy',
		'' AS 'AssignmentNotNeeded',
		'' AS 'Comment'					 			
	FROM	
		#FilteredCalls fc		
		JOIN [Secondary] s ON s.CallID = fc.CallID
	WHERE
		(@ProcessorType = 'CryoLife' AND s.SecondaryCryoLifeNumber IS NOT NULL)
		OR (@ProcessorType = 'MTF' AND s.SecondaryMTFNumber IS NOT NULL)
		OR (@ProcessorType = 'LifeNet' AND s.SecondaryLifeNetNumber IS NOT NULL);
END

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #ConvertedCalls;
DROP TABLE IF EXISTS #FilteredCalls;

GO
