SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_rpt_ApproachPersonOutcome]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[sps_rpt_ApproachPersonOutcome];
	PRINT 'Dropping sps_rpt_ApproachPersonOutcome';
End
GO

PRINT 'Creating sps_rpt_ApproachPersonOutcome';
GO

CREATE PROCEDURE sps_rpt_ApproachPersonOutcome
	@ReferralStartDateTime	DATETIME		= NULL,
	@ReferralEndDateTime	DATETIME  		= NULL,
	@ReportGroupID			INT				= NULL, 
	@OrganizationID			INT				= NULL,
	@SourceCodeName			VARCHAR (10)	= NULL,
	@CoordinatorID			INT				= NULL, 
	@LowerAgeLimit			INT				= NULL,
	@UpperAgeLimit			INT				= NULL,
	@Gender					VARCHAR (1)		= NULL,
	@DisplayMT				INT				= NULL
AS
/******************************************************************************
**		File: sps_rpt_ApproachPersonOutcome.sql
**		Name: sps_rpt_ApproachPersonOutcome
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
**		See Above
**
**		Called By:
**
**		Auth: christopher carroll
**		Date: 04/20/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**    	04/20/2007	ccarroll			Initial Release
**		11/20/2007  ccarroll			Added Time Zone search parameter and modified sproc 
**										to match requirements for revisions 4, 5
**		05/02/2008	ccarroll			Changed counting criteria to match requirement revision
**		05/20/2008	ccarroll			removed StatEmployeeApproach = @Coordinator in WHERE 
**		09/05/2008	ccarroll			Added conditional statement to determine if date range is in the Archive database
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**		11/06/2020	Mike Berenson		Refactored and eliminated need to call 
**											sps_rpt_ApproachPersonOutcome_Select.sql
**		11/19/2020	Mike Berenson		Fixed calculation of Approach field
****************************************************************************/

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;
DROP TABLE IF EXISTS #ReferralDetails

-- Load #SourceCodes
SELECT DISTINCT SourceCodeID
INTO #SourceCodes
FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);

-- Load #FilteredCalls
-- dbo.fn_rpt_ReferralDateTimeConversion limits the data returned by daterange and/or CallID
-- converting the date as appropriate.  These query results are then limited by #SourceCodes
SELECT 		
	cc.CallID, 
	cc.CallDateTime 
INTO #FilteredCalls
FROM dbo.fn_rpt_ReferralDateTimeConversion 
	(
		NULL						,
		@ReferralStartDateTime		,
		@ReferralEndDateTime		,
		NULL						,
		NULL						, 
		@DisplayMT		 
	) cc
	JOIN [Call] c ON c.CallID = cc.CallID
	JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeID;

-- Load #ReferralDetails
SELECT DISTINCT
	r.CallID,
	r.ReferralApproachedByPersonID AS 'ApproacherID',
	p.PersonLast AS 'ApproacherLastName',
	p.PersonFirst AS 'ApproacherFirstName',
	r.ReferralDonorGender,
	DATEDIFF(year, r.ReferralDOB, r.ReferralDonorDeathDate) -1 AS 'ReferralDonorAge',
	r.ReferralApproachTypeID,
	r.ReferralGeneralConsent,
	CASE WHEN sa.SecondaryApproachOutcome = 1 THEN 2 -- Triage Yes Verbal
			WHEN sa.SecondaryApproachOutcome = 2 THEN 1 -- Triage Yes Written
			ELSE sa.SecondaryApproachOutcome
	END AS 'SecondaryApproachOutcome',
	rs.RegistryStatus,
	r.ReferralOrganAppropriateID,
	r.ReferralOrganApproachID,
	r.ReferralOrganConsentID,
	r.ReferralBoneAppropriateID,
	r.ReferralBoneApproachID,
	r.ReferralBoneConsentID,
	r.ReferralTissueAppropriateID,
	r.ReferralTissueApproachID,
	r.ReferralTissueConsentID,
	r.ReferralSkinAppropriateID,
	r.ReferralSkinApproachID,
	r.ReferralSkinConsentID,
	r.ReferralEyesTransAppropriateID,
	r.ReferralEyesTransApproachID,
	r.ReferralEyesTransConsentID,
	r.ReferralEyesRschAppropriateID,
	r.ReferralEyesRschApproachID,
	r.ReferralEyesRschConsentID,
	r.ReferralValvesAppropriateID,
	r.ReferralValvesApproachID,
	r.ReferralValvesConsentID,
	CASE WHEN r.ReferralOrganApproachID = 1 
				OR r.ReferralBoneApproachID = 1 
				OR r.ReferralTissueApproachID = 1 
				OR r.ReferralSkinApproachID = 1 
				OR r.ReferralValvesApproachID = 1 
				OR r.ReferralEyesTransApproachID = 1 
				OR r.ReferralEyesRschApproachID = 1 THEN 1
			ELSE 0 END AS 'AnyOneReferralApproach',
	CASE WHEN r.ReferralOrganConsentID = 1 
				OR r.ReferralBoneConsentID = 1 
				OR r.ReferralTissueConsentID = 1 
				OR r.ReferralSkinConsentID = 1 
				OR r.ReferralValvesConsentID = 1 
				OR r.ReferralEyesTransConsentID = 1 
				OR r.ReferralEyesRschConsentID = 1 THEN 1
			ELSE 0 END AS 'AnyOneReferralConsent',
	CASE WHEN r.ReferralBoneConsentID = 1
				OR r.ReferralTissueConsentID = 1
				OR r.ReferralSkinConsentID = 1
				OR r.ReferralValvesConsentID = 1 
				OR r.ReferralEyesRschConsentID = 1 THEN 1
			ELSE 0 END AS 'OneOfBtsveReferralConsent',
	CASE WHEN rs.RegistryStatus IS NULL THEN 0
		WHEN rs.RegistryStatus = 1		-- StateRegistry
			OR rs.RegistryStatus = 2	-- WebRegistry
			OR rs.RegistryStatus = 4	-- ManuallyFound 
		THEN 1
		ELSE 0 END AS 'RegFound',
	CASE WHEN rs.RegistryStatus IS NULL
			OR rs.RegistryStatus = 5	-- NotChecked
			OR rs.RegistryStatus = 3	-- NotOnRegistry
			OR rs.RegistryStatus = -1	-- Blank
		THEN 1
		ELSE 0 END AS 'RegNotFound'
INTO #ReferralDetails
FROM 
	[Call] c
	JOIN #FilteredCalls fc			ON fc.CallID = c.CallID
	JOIN Referral r					ON r.CallID = c.CallID
	JOIN Person p					ON p.PersonID = r.ReferralApproachedByPersonID
	JOIN WebReportGroupOrg wrgo		ON wrgo.OrganizationID = r.ReferralCallerOrganizationID 
	LEFT JOIN StatEmployee se		ON se.PersonID = p.PersonID 
	LEFT JOIN SecondaryApproach sa	ON sa.CallID = r.CallID
	LEFT JOIN RegistryStatus rs		ON rs.CallID = r.CallID
	LEFT JOIN LogEvent le			ON le.CallID = c.CallID
WHERE
	wrgo.WebReportGroupID = @ReportGroupID
	AND	(@OrganizationID IS NULL OR r.ReferralCallerOrganizationID = @OrganizationID)	
	AND (@LowerAgeLimit IS NULL OR r.ReferralDonorAge >= @LowerAgeLimit)
	AND (@UpperAgeLimit IS NULL OR r.ReferralDonorAge <= @UpperAgeLimit)
	AND (@CoordinatorID IS NULL OR le.StatEmployeeID = @CoordinatorID)
	AND (@Gender IS NULL OR r.ReferralDonorGender = @Gender)	
	AND (
			r.ReferralApproachTypeID = 2	-- Pre-Ref, Coupled
			OR r.ReferralApproachTypeID = 3 -- Pre-Ref, Decoupled
			OR r.ReferralApproachTypeID = 4 -- Post Ref, Coupled
			OR r.ReferralApproachTypeID = 5 -- Post Ref, Decoupled
			OR r.ReferralApproachTypeID = 6 -- Family Initiated
			OR r.ReferralApproachTypeID = 8 -- Registry
			-- Explicitly excluded: (1) Not Approached and (7) Unknown
		);

-- Select Totals
SELECT
	ApproacherID,
	ApproacherLastName,
	ApproacherFirstName,

	/* Organ */
	SUM (CASE WHEN ReferralOrganApproachID = 1
			THEN 1 ELSE 0 END) AS 'OrganApproach',

	SUM (CASE WHEN ReferralGeneralConsent = 2
				AND ReferralOrganConsentID = 1
			THEN 1 ELSE 0 END) AS 'OrganVerbalConsent',

	SUM (CASE WHEN RegNotFound = 1
				AND ReferralOrganConsentID = 1 
				AND ISNULL(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			THEN 1 ELSE 0 END) AS 'OrganWrittenConsent',

	SUM (CASE WHEN RegFound = 1
				AND ISNULL(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
				AND ReferralOrganConsentID =1
			THEN 1 ELSE 0 END) AS 'OrganRegistryConsent',

	/* Tissue */
	SUM (CASE WHEN (ReferralBoneApproachID = 1 OR
				ReferralTissueApproachID = 1 OR
				ReferralSkinApproachID = 1 OR
				ReferralEyesRschApproachID = 1 OR
				ReferralValvesApproachID = 1
				)
			THEN 1 ELSE 0 END) AS 'TissueApproach',

	SUM (CASE WHEN ReferralGeneralConsent = 2
				AND OneOfBtsveReferralConsent = 1
			THEN 1 ELSE 0 END) AS 'TissueVerbalConsent',

	SUM (CASE WHEN RegNotFound = 1
				AND ISNULL(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
				AND OneOfBtsveReferralConsent = 1
			THEN 1 ELSE 0 END) AS 'TissueWrittenConsent',

	SUM (CASE WHEN ReferralGeneralConsent = 1
				AND RegFound = 1
				AND OneOfBtsveReferralConsent = 1
			THEN 1 ELSE 0 END) AS 'TissueRegistryConsent',

	/* EyesTrans - Eye */
	SUM (CASE WHEN ReferralEyesTransApproachID = 1
			THEN 1 ELSE 0 END) AS 'EyeApproach',

	SUM (CASE WHEN ReferralGeneralConsent = 2
				AND ReferralEyesTransConsentID = 1
			THEN 1 ELSE 0 END) AS 'EyeVerbalConsent',

	SUM (CASE WHEN RegNotFound = 1
				AND ISNULL(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
				AND ReferralEyesTransConsentID = 1
			THEN 1 ELSE 0 END) AS 'EyeWrittenConsent',

	SUM (CASE WHEN RegFound = 1
				AND ISNULL(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
				AND ReferralEyesTransConsentID = 1
			THEN 1 ELSE 0 END) AS 'EyeRegistryConsent',

	SUM (CASE WHEN (
				CASE WHEN ReferralOrganAppropriateID = -1 THEN 2 ELSE ReferralOrganAppropriateID END > 1 AND -- Not Appropriate
				CASE WHEN ReferralBoneAppropriateID = -1 THEN 2 ELSE ReferralBoneAppropriateID END > 1 AND
				CASE WHEN ReferralTissueAppropriateID = -1 THEN 2 ELSE ReferralTissueAppropriateID END > 1 AND
				CASE WHEN ReferralSkinAppropriateID = -1 THEN 2 ELSE ReferralSkinAppropriateID END > 1 AND
				CASE WHEN ReferralValvesAppropriateID = -1 THEN 2 ELSE ReferralValvesAppropriateID END > 1 AND
				CASE WHEN ReferralEyesTransAppropriateID = -1 THEN 2 ELSE ReferralEyesTransAppropriateID END > 1 AND
				CASE WHEN ReferralEyesRschAppropriateID = -1 THEN 2 ELSE ReferralEyesRschAppropriateID END > 1
				)
			THEN 1 ELSE 0 END) AS 'RuleoutApproach',
			  
	/* Employee Totals */
	SUM (CASE WHEN AnyOneReferralApproach = 1 
			THEN 1 ELSE 0 END) AS 'Approach',
			  
	SUM (CASE WHEN AnyOneReferralConsent = 1
				AND ReferralGeneralConsent = 2
			THEN 1 ELSE 0 END) AS 'VerbalConsent',
			  
	SUM (CASE WHEN 
				AnyOneReferralConsent = 1
				AND ISNULL(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
				AND RegNotFound = 1
			THEN 1 ELSE 0 END) AS 'WrittenConsent',

	SUM (CASE WHEN 
				AnyOneReferralConsent = 1
				AND ISNULL(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
				AND RegFound = 1
			THEN 1 ELSE 0 END) AS 'RegistryConsent',

	/* Start Total Consent */ 
	SUM (CASE WHEN 
				AnyOneReferralConsent = 1
				AND ReferralGeneralConsent = 2
			THEN 1 ELSE 0 END) +
			  
	SUM (CASE WHEN 
				AnyOneReferralConsent = 1
				AND ReferralGeneralConsent = 1
				AND RegNotFound = 1
			THEN 1 ELSE 0 END) +

	SUM (CASE WHEN 
				AnyOneReferralConsent = 1
				AND ReferralGeneralConsent = 1
				AND RegFound = 1
			THEN 1 ELSE 0 END) AS 'TotalConsent'
FROM #ReferralDetails
GROUP BY
	ApproacherID,
	ApproacherLastName,
	ApproacherFirstName;

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;
DROP TABLE IF EXISTS #ReferralDetails
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

