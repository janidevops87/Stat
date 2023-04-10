SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ApproachPersonOutcome]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_rpt_ApproachPersonOutcome]
	PRINT 'Dropping sps_rpt_ApproachPersonOutcome'
End
go

PRINT 'Creating sps_rpt_ApproachPersonOutcome'
GO

CREATE    PROCEDURE sps_rpt_ApproachPersonOutcome
	@ReferralStartDateTime	datetime	= NULL,
	@ReferralEndDateTime	datetime  	= NULL,
	@ReportGroupID			int		= NULL, 
	@OrganizationID			int		= NULL,
	@SourceCodeName			varchar (10)	= NULL,
	@CoordinatorID			int		= NULL, 
	@LowerAgeLimit			int		= NULL,
	@UpperAgeLimit			int		= NULL,
	@Gender					varchar (1)	= NULL,
	@DisplayMT				Int		= NULL
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
****************************************************************************/

	/* Create virtual table used in calulation */
	CREATE TABLE #sps_rpt_ApproachPersonOutcomeResults ( 
		CallID int,
		ReferralApproachedByPersonID int NULL,
		ReferralApproachedByPersonLastName varchar (50) NULL,
		ReferralApproachedByPersonFirstName varchar (50) NULL,
		ReferralDonorGender varchar (1) Null,
		ReferralDonorAge int NULL, -- years only
		ReferralApproachTypeID int NULL,
		ReferralGeneralConsent int NULL,
		SecondaryApproachOutcome int NULL,
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

--/* ccarroll 09/05/2008 Added statement to determine if date range is in Archive db */
--	DECLARE @maxTableDate DATETIME
--	DECLARE @OriginalEndDateTime DATETIME
--	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS
	
--	IF (ISNULL(@ReferralStartDateTime, GETDATE()) < @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--		/* Selection resides in archive db */
--			IF (ISNULL(@ReferralEndDateTime, GETDATE()) > @maxTableDate)
					
--				BEGIN /* Need to run in both archive and production databases */
--					SELECT @OriginalEndDateTime = @ReferralEndDateTime
--					SELECT @ReferralEndDateTime = @maxTableDate

--					/* run in Archive database */	
--					INSERT #sps_rpt_ApproachPersonOutcomeResults 
--						EXEC _ReferralProdArchive..sps_rpt_ApproachPersonOutcome_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
--					/* re-assign Start/End datetimes to run in production database */
--					SELECT @ReferralStartDateTime = @maxTableDate
--					SELECT @ReferralEndDateTime = @OriginalEndDateTime

--					/* run in production database */
--					INSERT #sps_rpt_ApproachPersonOutcomeResults 
--						EXEC sps_rpt_ApproachPersonOutcome_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
--				END
--			ELSE
--				BEGIN
--					/* run in Archive database only */	
--					INSERT #sps_rpt_ApproachPersonOutcomeResults 
--						EXEC _ReferralProdArchive..sps_rpt_ApproachPersonOutcome_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
--				END
--	ELSE
--			BEGIN	/* run in production database only */
			INSERT #sps_rpt_ApproachPersonOutcomeResults 
				EXEC sps_rpt_ApproachPersonOutcome_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @CoordinatorID, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
			--END



	SELECT
		ReferralApproachedByPersonID AS 'ApproacherID',
		ReferralApproachedByPersonLastName AS 'ApproacherLastName',
		ReferralApproachedByPersonFirstName AS 'ApproacherFirstName',

		/* Organ */
		sum (CASE WHEN ReferralOrganApproachID = 1
			       --AND ISNULL(RegistryStatus, -1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
			  THEN 1 ELSE 0 END) AS 'OrganApproach',

		sum (CASE WHEN ReferralGeneralConsent = 2
			       AND ReferralOrganConsentID =1
			  THEN 1 ELSE 0 END) AS 'OrganVerbalConsent',

		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
			       AND ReferralOrganConsentID =1 
				   AND IsNull(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			  THEN 1 ELSE 0 END) AS 'OrganWrittenConsent',

		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN(1, 2, 4) --(1)StateRegistry (2)WebRegistry (4)ManuallyFound 
				   AND IsNull(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			       AND ReferralOrganConsentID =1
			  THEN 1 ELSE 0 END) AS 'OrganRegistryConsent',

		/* Tissue */
		sum (CASE WHEN (ReferralBoneApproachID = 1 OR
				    ReferralTissueApproachID = 1 OR
				    ReferralSkinApproachID = 1 OR
				    ReferralEyesRschApproachID = 1 OR
				    ReferralValvesApproachID = 1
				    )
			       -- AND ISNULL(RegistryStatus, -1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
			  THEN 1 ELSE 0 END) AS 'TissueApproach',

		sum (CASE WHEN ReferralGeneralConsent = 2
			       AND (ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralEyesRschConsentID = 1 OR
				    ReferralValvesConsentID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'TissueVerbalConsent',

		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
				   AND IsNull(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			       AND (ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralEyesRschConsentID = 1 OR
				    ReferralValvesConsentID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'TissueWrittenConsent',

		sum (CASE WHEN ReferralGeneralConsent = 1
			       AND ISNULL(RegistryStatus, -1) IN(1, 2, 4) --(1)StateRegistry (2)WebRegistry (4)ManuallyFound
			       AND (ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralEyesRschConsentID = 1 OR
				    ReferralValvesConsentID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'TissueRegistryConsent',

		/* EyesTrans - Eye */
		sum (CASE WHEN ReferralEyesTransApproachID = 1
			       --AND ISNULL(RegistryStatus, -1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
			  THEN 1 ELSE 0 END) AS 'EyeApproach',

		sum (CASE WHEN ReferralGeneralConsent = 2
			       AND ReferralEyesTransConsentID = 1
			  THEN 1 ELSE 0 END) AS 'EyeVerbalConsent',

		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
				   AND IsNull(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			       AND ReferralEyesTransConsentID = 1
			  THEN 1 ELSE 0 END) AS 'EyeWrittenConsent',

		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN(1, 2, 4) --(1)StateRegistry (2)WebRegistry (4)ManuallyFound 
				   AND IsNull(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			       AND ReferralEyesTransConsentID = 1
			  THEN 1 ELSE 0 END) AS 'EyeRegistryConsent',

		sum (CASE WHEN (
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
		sum (CASE WHEN (
					ReferralOrganApproachID = 1 OR
					ReferralBoneApproachID = 1 OR
				    ReferralTissueApproachID = 1 OR
				    ReferralSkinApproachID = 1 OR
				    ReferralValvesApproachID = 1 OR
				    ReferralEyesTransApproachID = 1 OR
				    ReferralEyesRschApproachID = 1
				    )
			  THEN 1 ELSE 0 END) AS 'Approach',
			  
		sum (CASE WHEN (
					ReferralOrganConsentID = 1 OR
					ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralValvesConsentID = 1 OR
				    ReferralEyesTransConsentID = 1 OR
				    ReferralEyesRschConsentID = 1
				    )
			       AND ReferralGeneralConsent = 2
			  THEN 1 ELSE 0 END) AS 'VerbalConsent',
			  
		sum (CASE WHEN (
					ReferralOrganConsentID = 1 OR
					ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralValvesConsentID = 1 OR
				    ReferralEyesTransConsentID = 1 OR
				    ReferralEyesRschConsentID = 1
				    )
				   AND IsNull(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			       AND ISNULL(RegistryStatus,-1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
			  THEN 1 ELSE 0 END) AS 'WrittenConsent',

		sum (CASE WHEN (
					ReferralOrganConsentID = 1 OR
					ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralValvesConsentID = 1 OR
				    ReferralEyesTransConsentID = 1 OR
				    ReferralEyesRschConsentID = 1
				    )
				   AND IsNull(SecondaryApproachOutcome, ReferralGeneralConsent) = 1
			       AND ISNULL(RegistryStatus,-1) IN(1, 2, 4) --(1)StateRegistry (2)WebRegistry (4)ManuallyFound 
			  THEN 1 ELSE 0 END) AS 'RegistryConsent',

	/* Start Total Consent */ 
		sum (CASE WHEN (
					ReferralOrganConsentID = 1 OR
					ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralValvesConsentID = 1 OR
				    ReferralEyesTransConsentID = 1 OR
				    ReferralEyesRschConsentID = 1
				    )
			       AND ReferralGeneralConsent = 2
			  THEN 1 ELSE 0 END) +
			  
		sum (CASE WHEN (
					ReferralOrganConsentID = 1 OR
					ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralValvesConsentID = 1 OR
				    ReferralEyesTransConsentID = 1 OR
				    ReferralEyesRschConsentID = 1
				    )
				   AND ReferralGeneralConsent = 1
			       AND ISNULL(RegistryStatus,-1) IN(5, 3, -1) --(5)NotChecked (3)NotOnRegistry (-1)Blank
			  THEN 1 ELSE 0 END) +

		sum (CASE WHEN (
					ReferralOrganConsentID = 1 OR
					ReferralBoneConsentID = 1 OR
				    ReferralTissueConsentID = 1 OR
				    ReferralSkinConsentID = 1 OR
				    ReferralValvesConsentID = 1 OR
				    ReferralEyesTransConsentID = 1 OR
				    ReferralEyesRschConsentID = 1
				    )
				   AND ReferralGeneralConsent = 1
			       AND ISNULL(RegistryStatus,-1) IN(1, 2, 4) --(1)StateRegistry (2)WebRegistry (4)ManuallyFound 
			  THEN 1 ELSE 0 END) AS 'TotalConsent'
	/* End Total Consent */ 

	FROM #sps_rpt_ApproachPersonOutcomeResults
	GROUP BY
		ReferralApproachedByPersonID,
		ReferralApproachedByPersonLastName,
		ReferralApproachedByPersonFirstName
	ORDER BY
		ReferralApproachedByPersonLastName,
		ReferralApproachedByPersonFirstName

	

/* Test Select 
SELECT * FROM @TempReferralSelect
exec sps_rpt_ApproachPersonOutcome '11/11/2007 00:00', '11/11/2007 23:59', 37, Null, Null, Null, Null, Null, Null, 1

*/

DROP TABLE #sps_rpt_ApproachPersonOutcomeResults

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

