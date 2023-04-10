SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

DROP PROCEDURE IF EXISTS [dbo].[sps_rpt_InitialApproacherSummary_Select];
PRINT 'Dropping sps_rpt_InitialApproacherSummary_Select';
GO

PRINT 'Creating sps_rpt_InitialApproacherSummary_Select';
GO

CREATE PROCEDURE sps_rpt_InitialApproacherSummary_Select
	@ReferralStartDateTime	DATETIME		= NULL,
	@ReferralEndDateTime	DATETIME  		= NULL,
	@ReportGroupID			INT				= NULL, 
	@OrganizationID			INT				= NULL,
	@SourceCodeName			VARCHAR (10)	= NULL,
	@CoordinatorID			INT				= NULL, 
	@DisplayMT				INT				= NULL
AS
/******************************************************************************
**		File: sps_rpt_InitialApproacherSummary_Select.sql
**		Name: sps_rpt_InitialApproacherSummary_Select
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
**		Date: 09/16/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**  	09/16/2008	ccarroll			Initial Release
**		11/29/2020	Mike Berenson		Added to source control: App/Database/Create Scripts/Reports
**		11/29/2020	Mike Berenson		Refactored with temp tables to improve performance
**		02/01/2021	James Gerberich		Added a check on @OrganizationID.
****************************************************************************/


DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;

-- Load #SourceCodes
SELECT DISTINCT SourceCodeID
INTO #SourceCodes
FROM dbo.fn_SourceCodeList(@ReportGroupID, @SourceCodeName);

-- Check Organization ID
--NOTE: The current reporting site submits 194 (Statline) for the Organization ID if the user does not select an organization.
--	This results in an empty report because Statline no longer conducts family services.
--	We will default back to NULL if 194 is the submitted Organization ID
IF @OrganizationID = 194
BEGIN
	SET @OrganizationID = NULL
END;

-- Load #FilteredCalls
--NOTE: dbo.fn_rpt_ReferralDateTimeConversion queries the specified datarange
--Converting the date as appropriate
--The function limits the data returned by daterange and/or CallID
SELECT 		
	cc.CallID, 
	cc.CallDateTime 
INTO #FilteredCalls
FROM 
	dbo.fn_rpt_ReferralDateTimeConversion 
	(
		NULL,
		@ReferralStartDateTime,
		@ReferralEndDateTime,
		NULL,
		NULL, 
		@DisplayMT
	) cc
	JOIN [Call] c ON c.CallID = cc.CallID
	JOIN #SourceCodes sc ON sc.SourceCodeID = c.SourceCodeID;	

-- Run final select (with isnull checks)
SELECT
	r.CallID,
	sc.SourceCodeName,
	r.ReferralCallerOrganizationID,
	o.OrganizationName,
	r.ReferralApproachedByPersonID,
	ap.PersonLast							AS 'ApproachPersonLastName',
	ap.PersonFirst							AS 'ApproactPersonFirstName',
	ISNULL(r.ReferralApproachTypeID, -1)	AS 'ReferralApproachTypeID',
	ISNULL(r.ReferralGeneralConsent, -1)	AS 'ReferralGeneralConsent',
	ISNULL(rs.RegistryStatus, -1)			AS 'RegistryStatus',
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
	r.ReferralValvesConsentID
FROM 
	[Call] c
	JOIN #FilteredCalls fc		ON fc.CallID = c.CallID
	JOIN Referral r				ON c.CallID = r.CallID
	LEFT JOIN Person ap			ON r.ReferralApproachedByPersonID = ap.PersonID
	LEFT JOIN Organization o	ON o.OrganizationID = r.ReferralCallerOrganizationID
	LEFT JOIN SourceCode sc		ON sc.SourceCodeID = c.SourceCodeID
	JOIN WebReportGroupOrg wrgo ON wrgo.OrganizationID = r.ReferralCallerOrganizationID 
	LEFT JOIN RegistryStatus rs ON rs.CallID = r.CallID

WHERE	
	(@OrganizationID IS NULL OR r.ReferralCallerOrganizationID = @OrganizationID)
	AND (@CoordinatorID IS NULL OR r.ReferralApproachedByPersonID = @CoordinatorID)
	AND wrgo.WebReportGroupID = @ReportGroupID;

DROP TABLE IF EXISTS #SourceCodes;
DROP TABLE IF EXISTS #FilteredCalls;
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

