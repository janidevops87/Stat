SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_InitialApproacherSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_rpt_InitialApproacherSummary]
	PRINT 'Dropping sps_rpt_InitialApproacherSummary'
End
go

PRINT 'Creating sps_rpt_InitialApproacherSummary'
GO

CREATE    PROCEDURE sps_rpt_InitialApproacherSummary
	@ReferralStartDateTime	datetime	= NULL,
	@ReferralEndDateTime	datetime  	= NULL,
	@ReportGroupID			int		= NULL, 
	@OrganizationID			int		= NULL,
	@SourceCodeName			varchar (10)	= NULL,
	@CoordinatorID			int		= NULL, 
	@DisplayMT				Int		= NULL
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
****************************************************************************/

	/* Create virtual table used in calulation */
	CREATE TABLE #sps_rpt_InitialApproacherSummaryResults ( 
		CallID int,
		SourceCodeName varchar (15) NULL,
		ReferralCallerOrganizationID int NULL,
		OrganizationName varchar (50) NULL,
		ReferralApproachedByPersonID int Null,
		ApproachPersonLastName varchar (50) NULL,
		ApproachPersonFirstName varchar (50) NULL,
		ReferralApproachTypeID int NULL,
		ReferralGeneralConsent int NULL,
		RegistryStatus int NULL,
		ReferralOrganAppropriateID smallint NULL,
		ReferralOrganApproachID int NULL,
		ReferralOrganConsentID int NULL,
		ReferralBoneAppropriateID int NULL,
		ReferralBoneApproachID int NULL,
		ReferralBoneConsentID int NULL,
		ReferralTissueAppropriateID int NULL,
		ReferralTissueApproachID int NULL,
		ReferralTissueConsentID int NULL,
		ReferralSkinAppropriateID int NULL,
		ReferralSkinApproachID int NULL,
		ReferralSkinConsentID int NULL,
		ReferralEyesTransAppropriateID int NULL,
		ReferralEyesTransApproachID int NULL,
		ReferralEyesTransConsentID int NULL,
		ReferralEyesRschAppropriateID int NULL,
		ReferralEyesRschApproachID int NULL,
		ReferralEyesRschConsentID int NULL,
		ReferralValvesAppropriateID int NULL,
		ReferralValvesApproachID int NULL,
		ReferralValvesConsentID int NULL
		)

--/* determine if date range is in Archive db */
--	DECLARE @maxTableDate DATETIME
--	DECLARE @OriginalEndDateTime DATETIME
--	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS
	
--	IF (ISNULL(@ReferralStartDateTime, GETDATE()) < @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--		/* Selection resides in archive db */
--			IF (ISNULL(@ReferralEndDateTime, GETDATE()) > @maxTableDate)
					
--				BEGIN /* Need to run in both archive and production databases */

--					/* run in Archive database */	
--					INSERT #sps_rpt_ApproachPersonOutcomeResults 
--						EXEC _ReferralProdArchive..sps_rpt_InitialApproacherSummary_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @DisplayMT

--					/* run in production database */
--					INSERT #sps_rpt_ApproachPersonOutcomeResults 
--						EXEC sps_rpt_InitialApproacherSummary_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @DisplayMT
--				END
--			ELSE
--				BEGIN
--					/* run in Archive database only */	
--					INSERT #sps_rpt_InitialApproacherSummaryResults 
--						EXEC _ReferralProdArchive..sps_rpt_InitialApproacherSummary_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @DisplayMT
--				END
--	ELSE
--			BEGIN	/* run in production database only */
			INSERT #sps_rpt_InitialApproacherSummaryResults 
				EXEC sps_rpt_InitialApproacherSummary_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @DisplayMT
			--END



	SELECT
		ReferralCallerOrganizationID AS 'ReferralFacilityID',
		OrganizationName AS 'ReferralFacility',
		ReferralApproachedByPersonID,
		CASE WHEN ReferralApproachedByPersonID Not IN (-1, 0) THEN
				ApproachPersonLastName + ', ' + ApproachPersonFirstName
			ELSE 'Not Approached'
		END AS 'Approacher',

		/* Total Referrals */
		sum (CASE WHEN ISNULL(ReferralApproachTypeID, -1) IN(1, 7) --(1)Not Approached (7)Unknown
				AND ReferralApproachedByPersonID IN (-1, 0) 
				AND
					(
					ReferralOrganAppropriateID = 1 OR
					ReferralBoneAppropriateID = 1 OR
					ReferralTissueAppropriateID = 1 OR
					ReferralSkinAppropriateID = 1 OR
					ReferralValvesAppropriateID = 1 OR
					ReferralEyesTransAppropriateID = 1 OR
					ReferralEyesRschAppropriateID = 1
					)
			  THEN 0 ELSE 1 END) AS 'TotalReferrals',
		
		/* #RegistryApproach */
		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN(1, 2, 4, 6) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound (6)DLARegistry */ 
				AND ReferralApproachedByPersonID <> -1 /* Exclude Non Approached from count */
				AND
					(
					ReferralOrganApproachID = 1 OR
					ReferralBoneApproachID = 1 OR
				    ReferralTissueApproachID = 1 OR
				    ReferralSkinApproachID = 1 OR
				    ReferralValvesApproachID = 1 OR
					ReferralEyesTransApproachID = 1 OR
				    ReferralEyesRschApproachID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'RegistryApproach',
		
		/* #NonRegApproach */
		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank 
				AND ReferralApproachedByPersonID <> -1 /* Exclude Non Approached from count */
				AND
					(
					ReferralOrganApproachID = 1 OR
					ReferralBoneApproachID = 1 OR
				    ReferralTissueApproachID = 1 OR
				    ReferralSkinApproachID = 1 OR
				    ReferralValvesApproachID = 1 OR
					ReferralEyesTransApproachID = 1 OR
				    ReferralEyesRschApproachID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'NonRegApproach',

		/* #InitialPreReferral*/
		sum (CASE WHEN ISNULL(ReferralApproachTypeID, -1) IN(2, 3) --(2)Pre-RefCoupled (3)Pre-RefDeCoupled
				AND ReferralApproachedByPersonID <> -1 /* Exclude Non Approached from count */
				AND
					(
					ReferralOrganApproachID = 1 OR
					ReferralBoneApproachID = 1 OR
				    ReferralTissueApproachID = 1 OR
				    ReferralSkinApproachID = 1 OR
				    ReferralValvesApproachID = 1 OR
					ReferralEyesTransApproachID = 1 OR
				    ReferralEyesRschApproachID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'InitialPreReferral',

		/* #InitialFamilyInitiated*/
		sum (CASE WHEN ISNULL(ReferralApproachTypeID, -1) = 6 --(6)Family Initiated
				AND ReferralApproachedByPersonID <> -1 /* Exclude Non Approached from count */
				AND
					(
					ReferralOrganApproachID = 1 OR
					ReferralBoneApproachID = 1 OR
				    ReferralTissueApproachID = 1 OR
				    ReferralSkinApproachID = 1 OR
				    ReferralValvesApproachID = 1 OR
					ReferralEyesTransApproachID = 1 OR
				    ReferralEyesRschApproachID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'InitialFamilyInitiated',

		/* #Unknown/NotApproached*/
				sum (CASE WHEN ISNULL(ReferralApproachTypeID, -1) IN(1, 7) --(1)Not Approached (7)Unknown
						AND ReferralApproachedByPersonID IN (-1, 0) 
						AND
							(
							ReferralOrganAppropriateID = 1 OR
							ReferralBoneAppropriateID = 1 OR
							ReferralTissueAppropriateID = 1 OR
							ReferralSkinAppropriateID = 1 OR
							ReferralValvesAppropriateID = 1 OR
							ReferralEyesTransAppropriateID = 1 OR
							ReferralEyesRschAppropriateID = 1
							)
					  THEN 1 ELSE 0 END) AS 'Unknown',

		/* #TotalConsent */
		sum (CASE WHEN ISNULL(ReferralGeneralConsent, -1) = 1 --(1)Yes- Written
				AND ReferralApproachedByPersonID <> -1 /* Exclude Non Approached from count */
				AND
					(
					ReferralOrganConsentID = 1 OR
					ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralValvesConsentID = 1 OR
				    ReferralEyesTransConsentID = 1 OR
				    ReferralEyesRschConsentID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'TotalConsent'

	FROM #sps_rpt_InitialApproacherSummaryResults

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
		ApproachPersonFirstName
	

/* Test Select 
SELECT * FROM @TempReferralSelect
Exec sps_rpt_InitialApproacherSummary '09/01/2008 00:00', '09/01/2008 23:59', 37, Null, Null, Null, 1

*/

DROP TABLE #sps_rpt_InitialApproacherSummaryResults

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

