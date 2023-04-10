SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

DROP PROCEDURE IF EXISTS [dbo].[sps_rpt_InitialApproacherSummary];
PRINT 'Dropping sps_rpt_InitialApproacherSummary'
GO

PRINT 'Creating sps_rpt_InitialApproacherSummary';
GO

CREATE PROCEDURE sps_rpt_InitialApproacherSummary
	@ReferralStartDateTime	DATETIME		= NULL,
	@ReferralEndDateTime	DATETIME  		= NULL,
	@ReportGroupID			INT				= NULL, 
	@OrganizationID			INT				= NULL,
	@SourceCodeName			VARCHAR (10)	= NULL,
	@CoordinatorID			INT				= NULL, 
	@DisplayMT				INT				= NULL
AS
/******************************************************************************
**		File: sps_rpt_InitialApproacherSummary.sql
**		Name: sps_rpt_InitialApproacherSummary
**		Desc: 
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
**    	09/16/2008	ccarroll			Initial Release
**		09/24/2008	ccarroll			Added section for Archive db selection
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**      12/2016     Mike Berenson		Added DLA Registry
**		11/29/2020	Mike Berenson		Added to source control: App/Database/Create Scripts/Reports
**		11/29/2020	Mike Berenson		Refactored with temp tables to improve performance
**		01/29/2021	James Gerberich		Corrected PreReferral Calculation to look at ApproachType
****************************************************************************/

DROP TABLE IF EXISTS #sps_rpt_InitialApproacherSummaryResults;

-- Create virtual table used in calulation
CREATE TABLE #sps_rpt_InitialApproacherSummaryResults
( 
	CallID							INT,
	SourceCodeName					VARCHAR (15)	NULL,
	ReferralCallerOrganizationID	INT				NULL,
	OrganizationName				VARCHAR (80)	NULL,
	ReferralApproachedByPersonID	INT				NULL,
	ApproachPersonLastName			VARCHAR (50)	NULL,
	ApproachPersonFirstName			VARCHAR (50)	NULL,
	ReferralApproachTypeID			INT				NULL,
	ReferralGeneralConsent			INT				NULL,
	RegistryStatus					INT				NULL,
	ReferralOrganAppropriateID		SMALLINT		NULL,
	ReferralOrganApproachID			INT				NULL,
	ReferralOrganConsentID			INT				NULL,
	ReferralBoneAppropriateID		INT				NULL,
	ReferralBoneApproachID			INT				NULL,
	ReferralBoneConsentID			INT				NULL,
	ReferralTissueAppropriateID		INT				NULL,
	ReferralTissueApproachID		INT				NULL,
	ReferralTissueConsentID			INT				NULL,
	ReferralSkinAppropriateID		INT				NULL,
	ReferralSkinApproachID			INT				NULL,
	ReferralSkinConsentID			INT				NULL,
	ReferralEyesTransAppropriateID	INT				NULL,
	ReferralEyesTransApproachID		INT				NULL,
	ReferralEyesTransConsentID		INT				NULL,
	ReferralEyesRschAppropriateID	INT				NULL,
	ReferralEyesRschApproachID		INT				NULL,
	ReferralEyesRschConsentID		INT				NULL,
	ReferralValvesAppropriateID		INT				NULL,
	ReferralValvesApproachID		INT				NULL,
	ReferralValvesConsentID			INT				NULL
);

INSERT #sps_rpt_InitialApproacherSummaryResults 
EXEC sps_rpt_InitialApproacherSummary_Select 
	@ReferralStartDateTime = @ReferralStartDateTime, 
	@ReferralEndDateTime = @ReferralEndDateTime, 
	@ReportGroupID = @ReportGroupID, 
	@OrganizationID = @OrganizationID, 
	@SourceCodeName = @SourceCodeName, 
	@CoordinatorID = @CoordinatorID, 
	@DisplayMT = @DisplayMT;

SELECT
	ReferralCallerOrganizationID AS 'ReferralFacilityID',
	OrganizationName AS 'ReferralFacility',
	ReferralApproachedByPersonID,
	CASE WHEN ReferralApproachedByPersonID <> -1 AND ReferralApproachedByPersonID <> 0 THEN 
			ApproachPersonLastName + ', ' + ApproachPersonFirstName
		ELSE 'Not Approached' END						AS 'Approacher',

	/* Total Referrals */
	SUM(CASE WHEN 
				(
					ReferralApproachTypeID = 1		-- Not Approached
					OR ReferralApproachTypeID = 7	-- Unknown
				) 
				AND (
						ReferralApproachedByPersonID = -1 
						OR ReferralApproachedByPersonID = 0
					)
				AND (
						ReferralOrganAppropriateID = 1 
						OR ReferralBoneAppropriateID = 1 
						OR ReferralTissueAppropriateID = 1 
						OR ReferralSkinAppropriateID = 1 
						OR ReferralValvesAppropriateID = 1 
						OR ReferralEyesTransAppropriateID = 1 
						OR ReferralEyesRschAppropriateID = 1
					) THEN 0 
			ELSE 1 END)									AS 'TotalReferrals',
		
	/* #RegistryApproach */
	SUM(CASE WHEN 
				(
					RegistryStatus = 1		-- StateRegistry
					OR RegistryStatus= 2	-- WebRegistry
					OR RegistryStatus = 4	-- ManuallyFound
					OR RegistryStatus = 6	-- DLARegistry
				)
				AND ReferralApproachedByPersonID <> -1 -- Exclude Non Approached from count
				AND (
						ReferralOrganApproachID = 1
						OR ReferralBoneApproachID = 1 
						OR ReferralTissueApproachID = 1 
						OR ReferralSkinApproachID = 1 
						OR ReferralValvesApproachID = 1 
						OR ReferralEyesTransApproachID = 1 
						OR ReferralEyesRschApproachID = 1
					) THEN 1 
			ELSE 0 END)									AS 'RegistryApproach',
		
	/* #NonRegApproach */
	SUM(CASE WHEN
				(
					RegistryStatus = 5		-- NotChecked
					OR RegistryStatus= 3	-- NotOnRegistry
					OR RegistryStatus = -1	-- Blank
				)
				AND ReferralApproachedByPersonID <> -1 -- Exclude Non Approached from count
				AND (
						ReferralOrganApproachID = 1
						OR ReferralBoneApproachID = 1 
						OR ReferralTissueApproachID = 1 
						OR ReferralSkinApproachID = 1 
						OR ReferralValvesApproachID = 1 
						OR ReferralEyesTransApproachID = 1 
						OR ReferralEyesRschApproachID = 1
					) THEN 1 
			ELSE 0 END)									AS 'NonRegApproach',

	/* #InitialPreReferral*/
	SUM(CASE WHEN
				(
					ReferralApproachTypeID = 2		-- Pre-RefCoupled
					OR ReferralApproachTypeID= 3	-- Pre-RefDeCoupled
				) 
				AND ReferralApproachedByPersonID <> -1 -- Exclude Non Approached from count
				AND (
						ReferralOrganApproachID = 1
						OR ReferralBoneApproachID = 1 
						OR ReferralTissueApproachID = 1 
						OR ReferralSkinApproachID = 1 
						OR ReferralValvesApproachID = 1 
						OR ReferralEyesTransApproachID = 1 
						OR ReferralEyesRschApproachID = 1
					) THEN 1 
			ELSE 0 END)									AS 'InitialPreReferral',

	/* #InitialFamilyInitiated*/
	SUM(CASE WHEN ReferralApproachTypeID = 6 -- Family Initiated
				AND ReferralApproachedByPersonID <> -1 -- Exclude Non Approached from count
				AND (
						ReferralOrganApproachID = 1
						OR ReferralBoneApproachID = 1 
						OR ReferralTissueApproachID = 1 
						OR ReferralSkinApproachID = 1 
						OR ReferralValvesApproachID = 1 
						OR ReferralEyesTransApproachID = 1 
						OR ReferralEyesRschApproachID = 1
					) THEN 1 
			ELSE 0 END)									AS 'InitialFamilyInitiated',

	/* #Unknown/NotApproached*/
	SUM(CASE WHEN 
				(
					ReferralApproachTypeID = 1		-- Not Approached
					OR ReferralApproachTypeID = 7	-- Unknown
				) 
			AND (
					ReferralApproachedByPersonID = -1
					OR ReferralApproachedByPersonID = 0
				) 
			AND (
					ReferralOrganAppropriateID = 1 
					OR ReferralBoneAppropriateID = 1 
					OR ReferralTissueAppropriateID = 1 
					OR ReferralSkinAppropriateID = 1 
					OR ReferralValvesAppropriateID = 1 
					OR ReferralEyesTransAppropriateID = 1 
					OR ReferralEyesRschAppropriateID = 1
				)
			THEN 1 ELSE 0 END) AS 'Unknown',

	/* #TotalConsent */
	SUM(CASE WHEN ReferralGeneralConsent = 1 --(1)Yes- Written
				AND ReferralApproachedByPersonID <> -1 -- Exclude Non Approached from count
				AND (
						ReferralOrganConsentID = 1 
						OR ReferralBoneConsentID = 1 
						OR ReferralTissueConsentID = 1
						OR ReferralSkinConsentID = 1 
						OR ReferralValvesConsentID = 1 
						OR ReferralEyesTransConsentID = 1 
						OR ReferralEyesRschConsentID = 1
					)
				THEN 1 ELSE 0 END) AS 'TotalConsent'

FROM 
	#sps_rpt_InitialApproacherSummaryResults
GROUP BY
	ReferralCallerOrganizationID,
	OrganizationName,
	ReferralApproachedByPersonID,
	ApproachPersonLastName,
	ApproachPersonFirstName		
ORDER BY
	ReferralCallerOrganizationID,
	OrganizationName,
	ReferralApproachedByPersonID,
	ApproachPersonLastName,
	ApproachPersonFirstName;	

DROP TABLE IF EXISTS #sps_rpt_InitialApproacherSummaryResults;
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

