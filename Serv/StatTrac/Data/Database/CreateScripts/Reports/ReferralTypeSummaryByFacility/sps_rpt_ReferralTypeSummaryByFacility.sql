SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ReferralTypeSummaryByFacility]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[sps_rpt_ReferralTypeSummaryByFacility]
	PRINT 'Dropping sps_rpt_ReferralTypeSummaryByFacility'
End
go

PRINT 'Creating sps_rpt_ReferralTypeSummaryByFacility'
GO

CREATE    PROCEDURE sps_rpt_ReferralTypeSummaryByFacility
	@ReferralStartDateTime	datetime	= NULL,
	@ReferralEndDateTime	datetime  	= NULL,
	@ReportGroupID			int		= NULL, 
	@OrganizationID			int		= NULL,
	@SourceCodeName			varchar (10)	= NULL,
	--@CoordinatorID			int		= NULL,
	@LowerAgeLimit			int = Null,
	@UpperAgeLimit			int = Null,
	@Gender					varchar(1) = Null,
	@DisplayMT				int		= NULL
AS
/******************************************************************************
**		File: sps_rpt_ReferralTypeSummaryByFacility.sql
**		Name: sps_rpt_ReferralTypeSummaryByFacility
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
**    	09/22/2008	ccarroll			Initial Release
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
****************************************************************************/

	/* Create temp table for initial select */
	CREATE TABLE #sps_rpt_ReferralTypeSummaryByFacilityResults ( 
		CallID int,
		SourceCodeName varchar (15) NULL,
		ReferralCallerOrganizationID int NULL,
		OrganizationName varchar (150) NULL,

		CurrentReferralTypeID int NULL,
		ReferralTypeID int NULL,
		
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
--					INSERT #sps_rpt_ReferralTypeSummaryByFacilityResults 
--						EXEC _ReferralProdArchive..sps_rpt_ReferralTypeSummaryByFacility_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT

--					/* run in production database */
--					INSERT #sps_rpt_ReferralTypeSummaryByFacilityResults 
--						EXEC sps_rpt_ReferralTypeSummaryByFacility_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
--				END
--			ELSE
--				BEGIN
--					/* run in Archive database only */	
--					INSERT #sps_rpt_ReferralTypeSummaryByFacilityResults 
--						EXEC _ReferralProdArchive..sps_rpt_ReferralTypeSummaryByFacility_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
--				END
--	ELSE
--			BEGIN	/* run in production database only */
			INSERT #sps_rpt_ReferralTypeSummaryByFacilityResults 
				EXEC sps_rpt_ReferralTypeSummaryByFacility_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @LowerAgeLimit, @UpperAgeLimit, @Gender, @DisplayMT
--			END

/* Registered Referrals */
--INSERT @TempDisplay
	SELECT
		ReferralCallerOrganizationID AS 'ReferralFacilityID',
		OrganizationName AS 'ReferralFacility',

		/* Registered Referrals */
		'Registered Referrals' AS 'Collection',

		/* Total Registered Referrals */
		sum (CASE WHEN ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */ 
			  THEN 0 ELSE 1 END) AS 'TotalReferrals',
		
		/* OTE Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 1 /* (1)Organ/Tissue/Eye */
				AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'OTE',
		
		/* Tissue Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
				AND ReferralOrganAppropriateID = 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
						AND
							(
							ReferralBoneAppropriateID = 1 OR
							ReferralTissueAppropriateID = 1 OR
							ReferralSkinAppropriateID = 1 OR
							ReferralValvesAppropriateID = 1
							)
				AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Tissue',

		/* TE Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
						AND
							(
							ReferralBoneAppropriateID = 1 OR
							ReferralTissueAppropriateID = 1 OR
							ReferralSkinAppropriateID = 1 OR
							ReferralValvesAppropriateID = 1
							)
				AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'TE',

		/* Eyes Only Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 3		/* (3)Eyes Only */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
				AND	ReferralBoneAppropriateID <> 1
				AND ReferralTissueAppropriateID <> 1
				AND ReferralSkinAppropriateID <> 1
				AND ReferralValvesAppropriateID <> 1
				AND ReferralEyesRschAppropriateID <> 1
				AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Eye Only',

		/* Other/Eye Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) IN (3, 4)	/* (3)Eyes Only (4)Ruleout */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1
				AND	ReferralBoneAppropriateID <> 1
				AND ReferralTissueAppropriateID <> 1
				AND ReferralSkinAppropriateID <> 1
				AND ReferralValvesAppropriateID <> 1
				AND ReferralEyesRschAppropriateID = 1
				AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Other/Eye',

		/* Other Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID <> 1
				AND	ReferralBoneAppropriateID <> 1
				AND ReferralTissueAppropriateID <> 1
				AND ReferralSkinAppropriateID <> 1
				AND ReferralValvesAppropriateID <> 1
				AND ReferralEyesRschAppropriateID = 1
				AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Other',

		/* Age RO Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
				AND	IsNull(ReferralBoneAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralTissueAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralSkinAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralValvesAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
				AND IsNull(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Age RO',

		/* Med RO Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
				AND	(   IsNull(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
						OR IsNull(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
						OR IsNull(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
						OR IsNull(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
					)
				AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
				AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Med RO'
	FROM #sps_rpt_ReferralTypeSummaryByFacilityResults
	GROUP BY
		ReferralCallerOrganizationID,
		OrganizationName

UNION ALL
/* Total Referrals */
--INSERT @TempDisplay
	SELECT
		ReferralCallerOrganizationID AS 'ReferralFacilityID',
		OrganizationName AS 'ReferralFacility',

		/* Registered Referrals */
		'Total Referrals' AS 'Collection',

		/* Total Registered Referrals */
		Count(*) AS 'TotalReferrals',
		
		/* OTE Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 1 /* (1)Organ/Tissue/Eye */
				--AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'OTE',
		
		/* Tissue Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
				AND ReferralOrganAppropriateID = 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
						AND
							(
							ReferralBoneAppropriateID = 1 OR
							ReferralTissueAppropriateID = 1 OR
							ReferralSkinAppropriateID = 1 OR
							ReferralValvesAppropriateID = 1
							)
				--AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Tissue',

		/* TE Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 2		/* (2)Tissue/Eye */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
						AND
							(
							ReferralBoneAppropriateID = 1 OR
							ReferralTissueAppropriateID = 1 OR
							ReferralSkinAppropriateID = 1 OR
							ReferralValvesAppropriateID = 1
							)
				--AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'TE',

		/* Eyes Only Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 3		/* (3)Eyes Only */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1	/* (1) Yes */
				AND	ReferralBoneAppropriateID <> 1
				AND ReferralTissueAppropriateID <> 1
				AND ReferralSkinAppropriateID <> 1
				AND ReferralValvesAppropriateID <> 1
				AND ReferralEyesRschAppropriateID <> 1
				--AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Eye Only',

		/* Other/Eye Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) IN (3, 4)	/* (3)Eyes Only (4)Ruleout */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID = 1
				AND	ReferralBoneAppropriateID <> 1
				AND ReferralTissueAppropriateID <> 1
				AND ReferralSkinAppropriateID <> 1
				AND ReferralValvesAppropriateID <> 1
				AND ReferralEyesRschAppropriateID = 1
				--AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Other/Eye',

		/* Other Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
				AND ReferralOrganAppropriateID <> 1		/* (1) Yes */
				AND ReferralEyesTransAppropriateID <> 1
				AND	ReferralBoneAppropriateID <> 1
				AND ReferralTissueAppropriateID <> 1
				AND ReferralSkinAppropriateID <> 1
				AND ReferralValvesAppropriateID <> 1
				AND ReferralEyesRschAppropriateID = 1
				--AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Other',

		/* Age RO Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
				AND	IsNull(ReferralBoneAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralTissueAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralSkinAppropriateID, -1) Not IN (3, 4)		/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralValvesAppropriateID, -1) Not IN (3, 4)	/* (3)High Risk (4)Med RO */
				AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
				--AND IsNull(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Age RO',

		/* Med RO Registered Referrals */
		sum (CASE WHEN IsNull(ReferralTypeID, 0) = 4 /* (4)Ruleout */
				AND	(   IsNull(ReferralBoneAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
						OR IsNull(ReferralTissueAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
						OR IsNull(ReferralSkinAppropriateID, -1) IN (3, 4)		/* (3)High Risk (4)Med RO */
						OR IsNull(ReferralValvesAppropriateID, -1) IN (3, 4)	/* (3)High Risk (4)Med RO */
					)
				AND IsNull(ReferralEyesRschAppropriateID, -1) <> 1			/* (1) Yes */
				--AND ISNULL(RegistryStatus, -1) IN (1, 2, 4) /* (1)StateRegistry (2)WebRegistry (4)ManuallyFound */
			  THEN 1 ELSE 0 END) AS 'Med RO'
	FROM #sps_rpt_ReferralTypeSummaryByFacilityResults

	GROUP BY
		ReferralCallerOrganizationID,
		OrganizationName

	ORDER BY
		OrganizationName,
		Collection


/* Test Select 
Exec sps_rpt_ReferralTypeSummaryByFacility '03/01/2008 00:00', '03/23/2008 23:59', 37, Null, 'CO', 47, 55, 'M', 1

SELECT 
		ID,
		ReferralFacilityID,
		ReferralFacility,
		Collection,
		TotalReferrals,
		OTE,
		Tissue,
		TE,
		EyeOnly,
		OtherEye,
		Other,
		AgeRO,
		MedRO

FROM @TempDisplay
Group By
*/


DROP TABLE #sps_rpt_ReferralTypeSummaryByFacilityResults

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

