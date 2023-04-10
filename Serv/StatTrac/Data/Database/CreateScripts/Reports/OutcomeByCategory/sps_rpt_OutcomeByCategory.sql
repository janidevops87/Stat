IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_rpt_OutcomeByCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sps_rpt_OutcomeByCategory]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE     PROCEDURE [dbo].[sps_rpt_OutcomeByCategory]
	@ReferralStartDateTime		datetime	= NULL ,
	@ReferralEndDateTime		datetime  	= NULL ,
	@ReportGroupID			int			= NULL , 
	@OrganizationID			int			= NULL ,
	@SourceCodeName			varchar (10) = NULL ,
	@DisplayMT				int	= Null
	 
AS
	-- set transaction isolation level
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
/******************************************************************************
**		File: sps_rpt_OutcomeByCategory.sql
**		Name: sps_rpt_OutcomeByCategory
**		Desc: 
**
**		Return values:
** 
**		Called by: OutcomeByCategory.rdl              
**		Parameters:
**		See above
**		
**		Auth: ccarroll
**		Date: 08/14/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------		-------------------------------------------
**		08/14/2008		ccarroll		Initial Release
**		09/24/2008		ccarroll		Added selection for Archive db
**      03/2009         jth             was running the insert table sproc twice
**		02/10/2010		James Gerberich	Added count of Registered Donors for 
**										'No' Consents and 'No' Recoveries - HS 17696
**		12/03/2012		James Gerberich	Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**      12/12/2016      Mike Berenson	Added DLA Registry
****************************************************************************/
/* This section can be un-commented and used for quick testing*/
--DECLARE
--	@ReferralStartDateTime		datetime,
--	@ReferralEndDateTime		datetime,
--	@ReportGroupID			int,
--	@OrganizationID			int,
--	@SourceCodeName			varchar (10),
--	@DisplayMT				int

--SELECT
--	@ReferralStartDateTime = 'Feb  1 2009 12:00:00:000AM',
--	@ReferralEndDateTime = 'Feb 28 2010 11:59:00:000PM',
--	@ReportGroupID = 846,
--	@OrganizationID = NULL,
--	@SourceCodeName = NULL,
--	@DisplayMT = 0


DECLARE @SQLString varchar(1000)
/* Create Temp table select */
	CREATE TABLE #Temp_OutcomeByCategory_Select 

	(	/* Call Details */
		[CallID] [INT] ,
		[CallDateTime] [DATETIME] , 
		[CallSourceCodeID] [INT] NULL , 
		[CallStatEmployeeID] [INT] NULL,

		[ReferralGeneralConsent] [INT] NULL,
		[ReferralTypeID] [INT] NULL,
		[ReferralCallerOrganizationID] [INT] NULL, 
		[RegistryStatus] [INT] NULL,

		[ReferralOrganAppropriateID] [INT] NULL , 
		[ReferralBoneAppropriateID] [INT] NULL , 
		[ReferralTissueAppropriateID] [INT] NULL , 
		[ReferralSkinAppropriateID] [INT] NULL , 
		[ReferralEyesTransAppropriateID] [INT] NULL , 
		[ReferralEyesRschAppropriateID] [INT] NULL , 
		[ReferralValvesAppropriateID] [INT] NULL , 

		[ReferralOrganApproachID] [INT] NULL , 
		[ReferralBoneApproachID] [INT] NULL , 
		[ReferralTissueApproachID] [INT] NULL , 
		[ReferralSkinApproachID] [INT] NULL , 
		[ReferralEyesTransApproachID] [INT] NULL , 
		[ReferralEyesRschApproachID] [INT] NULL , 
		[ReferralValvesApproachID] [INT] NULL , 

		[ReferralOrganConsentID] [INT] NULL , 
		[ReferralBoneConsentID] [INT] NULL , 
		[ReferralTissueConsentID] [INT] NULL , 
		[ReferralSkinConsentID] [INT] NULL , 
		[ReferralEyesTransConsentID] [INT] NULL , 
		[ReferralEyesRschConsentID] [INT] NULL , 
		[ReferralValvesConsentID] [INT] NULL , 

		[ReferralOrganConversionID] [INT] NULL , 
		[ReferralBoneConversionID] [INT] NULL , 
		[ReferralTissueConversionID] [INT] NULL , 
		[ReferralSkinConversionID] [INT] NULL , 
		[ReferralEyesTransConversionID] [INT] NULL , 
		[ReferralEyesRschConversionID] [INT] NULL , 
		[ReferralValvesConversionID] [INT]  NULL 
	)
	
	
	/* Create virtual table for Registry Status Type */
	DECLARE @RegistryStatusType Table
	(
		ID int,
		RegistryType varchar(50),
		DisplayOrder int
	)

INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(1, 'State Registry', 1)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(2, 'Web Registry', 2)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(3, 'Not Registered', 4)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(4, 'Manually Found', 3)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(5, 'Not Checked', 5)
INSERT INTO @RegistryStatusType(ID, RegistryType, DisplayOrder) VALUES(6, 'DLA Registry', 6);
	

	/*	Create virtual table used in finial display */
	DECLARE	@TempCounts TABLE
	 ( 
		ID int identity(1,1),
		FormatCode int NULL,	/* Values to format row: -1 Hidden, 0 = None, 1 = Bold, 2 = Bold & Italic */
		Disposition varchar(50) NULL,
		GroupingCode int Null,	/* This field is used to group and calculate sub-totals in report */
		Type varchar (50) Null,

		/* Counts */
		Organ int NULL,
		/* 2/10/10 Adding counts for Registered Donors by Organ/Tissue per HS 17696 */
		OrganReg int NULL,
		Bone int NULL,
		BoneReg int NULL,
		Soft_Tissue int NULL,
		TissueReg int NULL,
		Skin int NULL,
		SkinReg int NULL,
		Valves int NULL,
		ValvesReg int NULL,
		Eyes int NULL,
		EyesReg int NULL,
		Other int NULL,
		OtherReg int NULL,

		/* Totals */
		Total_StateRegistry int Default(0),
		Total_WebRegistry int Default(0),
		Total_ManuallyFound int Default(0),
		Total_NotRegistered int Default(0),
		Total_DlaRegistry INT DEFAULT(0),
		Total_Referrals int Default(0)
	 )

	 
	/* #Temp_OutcomeByCategory_Select initial selection  comment this out...why this was running twice? jth
			INSERT INTO #Temp_OutcomeByCategory_Select
				EXEC sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT*/

--/* determine if date range is in Archive db */
--	DECLARE @maxTableDate DATETIME
--	DECLARE @OriginalEndDateTime DATETIME
--	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS
	
--	IF (ISNULL(@ReferralStartDateTime, GETDATE()) < @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--		/* Selection resides in archive db */
--			IF (ISNULL(@ReferralEndDateTime, GETDATE()) > @maxTableDate)
					
--				BEGIN /* Need to run in both archive and production databases */

--					/* run in Archive database */	
--					INSERT #Temp_OutcomeByCategory_Select 
--						EXEC _ReferralProdArchive..sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT

--					/* run in production database */
--					INSERT #Temp_OutcomeByCategory_Select 
--						EXEC sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT
--				END
--			ELSE
--				BEGIN
--					/* run in Archive database only */	
--					INSERT #Temp_OutcomeByCategory_Select 
--						EXEC _ReferralProdArchive..sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT
--				END
--	ELSE
--			BEGIN	/* run in production database only */
			INSERT #Temp_OutcomeByCategory_Select
				EXEC sps_rpt_OutcomeByCategory_Select @ReferralStartDateTime, @ReferralEndDateTime, @ReportGroupID, @OrganizationID, @SourceCodeName, @DisplayMT
			--END


/*** Start Counts ***/
/*** Calculate Totals and set to local variables ***/

/* TOTAL Referrals Total */
DECLARE @TotalReferralStateRegistry int
DECLARE @TotalReferralWebRegistry int
DECLARE @TotalReferralManuallyFound int
DECLARE @TotalReferralNotRegistered int,
		@TotalReferralDlaRegistry INT
DECLARE @TotalReferralReferrals int

	SELECT
		@TotalReferralStateRegistry = TOS.Total_StateRegistry,
		@TotalReferralWebRegistry = TOS.Total_WebRegistry,
		@TotalReferralManuallyFound = TOS.Total_ManuallyFound,
		@TotalReferralNotRegistered = TOS.Total_NotRegistered,
		@TotalReferralDlaRegistry = TOS.Total_DlaRegistry, 
		@TotalReferralReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
				SUM(CASE WHEN RegistryStatus = 1 THEN 1 ELSE 0 END) AS 'Total_StateRegistry',
				SUM(CASE WHEN RegistryStatus = 2 THEN 1 ELSE 0 END) AS 'Total_WebRegistry',
				SUM(CASE WHEN RegistryStatus = 4 THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',
				SUM(CASE WHEN RegistryStatus = 6 THEN 1 ELSE 0 END) AS 'Total_DlaRegistry',
				SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',
				Count(CallID) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS


/* Appropriate Totals */
DECLARE @TotalAppropriateReferrals int

	SELECT
		@TotalAppropriateReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
			
			SUM(CASE WHEN 
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS


/* Approach Totals */
DECLARE @TotalApproachStateRegistry int
DECLARE @TotalApproachWebRegistry int
DECLARE @TotalApproachManuallyFound int
DECLARE @TotalApproachNotRegistered int,
		@TotalApproachDlaRegistry INT;
DECLARE @TotalApproachReferrals int

	SELECT
		@TotalApproachStateRegistry = TOS.Total_StateRegistry,
		@TotalApproachWebRegistry = TOS.Total_WebRegistry,
		@TotalApproachManuallyFound = TOS.Total_ManuallyFound,
		@TotalApproachNotRegistered = TOS.Total_NotRegistered,
		@TotalApproachDlaRegistry = TOS.Total_DlaRegistry,
		@TotalApproachReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
			SUM(CASE WHEN RegistryStatus = 1 AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

			SUM(CASE WHEN RegistryStatus = 2 AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

			SUM(CASE WHEN RegistryStatus = 4 AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

			SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',

			SUM(CASE WHEN RegistryStatus = 6 AND
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				) THEN 1 ELSE 0 END) AS 'Total_DlaRegistry',
			
			SUM(CASE WHEN 
				(ReferralOrganApproachID = 1
				 OR ReferralBoneApproachID = 1 
				 OR ReferralTissueApproachID = 1
				 OR ReferralSkinApproachID = 1 
				 OR ReferralValvesApproachID = 1
				 OR ReferralEyesTransApproachID = 1
				 OR ReferralEyesRschApproachID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS

/* Consent Totals */
DECLARE @TotalConsentStateRegistry int
DECLARE @TotalConsentWebRegistry int
DECLARE @TotalConsentManuallyFound int
DECLARE @TotalConsentNotRegistered int,
		@TotalConsentDlaRegistry INT;
DECLARE @TotalConsentReferrals int

	SELECT
		@TotalConsentStateRegistry = TOS.Total_StateRegistry,
		@TotalConsentWebRegistry = TOS.Total_WebRegistry,
		@TotalConsentManuallyFound = TOS.Total_ManuallyFound,
		@TotalConsentNotRegistered = TOS.Total_NotRegistered,
		@TotalConsentDlaRegistry = TOS.Total_DlaRegistry,
		@TotalConsentReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
			SUM(CASE WHEN RegistryStatus = 1 AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

			SUM(CASE WHEN RegistryStatus = 2 AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

			SUM(CASE WHEN RegistryStatus = 4 AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

			SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',

			SUM(CASE WHEN RegistryStatus = 6 AND
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				) THEN 1 ELSE 0 END) AS 'Total_DlaRegistry',
			
			SUM(CASE WHEN 
				(ReferralOrganConsentID = 1
				 OR ReferralBoneConsentID = 1 
				 OR ReferralTissueConsentID = 1
				 OR ReferralSkinConsentID = 1 
				 OR ReferralValvesConsentID = 1
				 OR ReferralEyesTransConsentID = 1
				 OR ReferralEyesRschConsentID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS

/* Recovery Totals */
DECLARE @TotalRecoveryStateRegistry int
DECLARE @TotalRecoveryWebRegistry int
DECLARE @TotalRecoveryManuallyFound int
DECLARE @TotalRecoveryNotRegistered int,
		@TotalRecoveryDlaRegistry INT;
DECLARE @TotalRecoveryReferrals int

	SELECT
		@TotalRecoveryStateRegistry = TOS.Total_StateRegistry,
		@TotalRecoveryWebRegistry = TOS.Total_WebRegistry,
		@TotalRecoveryManuallyFound = TOS.Total_ManuallyFound,
		@TotalRecoveryNotRegistered = TOS.Total_NotRegistered,
		@TotalRecoveryDlaRegistry = TOS.Total_DlaRegistry,
		@TotalRecoveryReferrals = TOS.Total_Referrals
		FROM 
			(SELECT
					SUM(CASE WHEN RegistryStatus = 1 AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

				SUM(CASE WHEN RegistryStatus = 2 AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

				SUM(CASE WHEN RegistryStatus = 4 AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

				SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',

				SUM(CASE WHEN RegistryStatus = 6 AND
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					) THEN 1 ELSE 0 END) AS 'Total_DlaRegistry',
				
				SUM(CASE WHEN 
					(ReferralOrganConversionID = 1
					 OR ReferralBoneConversionID = 1 
					 OR ReferralTissueConversionID = 1
					 OR ReferralSkinConversionID = 1 
					 OR ReferralValvesConversionID = 1
					 OR ReferralEyesTransConversionID = 1
					 OR ReferralEyesRschConversionID = 1
					 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
		FROM	#Temp_OutcomeByCategory_Select) AS TOS




/*** APPROPRIATE ***/
	/* Registry Appropriate */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)
	SELECT
			0 AS 'FormatCode',
			'Appropriate' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1 = Blank
				 1 = Yes
				 3 = Not on Registry
				 5 = Not Checked
			*/
			SUM(CASE WHEN ReferralOrganAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschAppropriateID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry',
			@TotalReferralReferrals AS 'Total_Referrals'

	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Appropriate - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Appropriate' AS 'Disposition',
			2 AS 'GroupingCode', 
			Appropriate.AppropriateName AS 'Type',
			SUM(CASE WHEN ReferralOrganAppropriateID > 1 AND ReferralOrganAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN ReferralBoneAppropriateID > 1 AND ReferralBoneAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueAppropriateID > 1 AND ReferralTissueAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN ReferralSkinAppropriateID > 1 AND ReferralSkinAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesAppropriateID > 1 AND ReferralValvesAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransAppropriateID > 1 AND ReferralEyesTransAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschAppropriateID > 1 AND ReferralEyesRschAppropriateID = AppropriateID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry',
			@TotalReferralReferrals AS 'Total_Referrals'
			
	FROM 	Appropriate, #Temp_OutcomeByCategory_Select
	WHERE	Appropriate.AppropriateID > 1 AND Appropriate.Inactive <> 1
	GROUP BY Appropriate.AppropriateName,
			 Appropriate.AppropriateReportDisplaySort1
--	ORDER BY Appropriate.AppropriateReportDisplaySort1
	ORDER BY Appropriate.AppropriateName

/*** End APPROPRIATE ***/


/*** APPROACH ***/
	/* Registry Approach */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)

	SELECT
			0 AS 'FormatCode',
			'Approach' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1 = Blank
				 1 = Yes
				 3 = Not on Registry
				 5 = Not Checked
			*/
			SUM(CASE WHEN ReferralOrganApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschApproachID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry', 
			@TotalAppropriateReferrals AS 'Total_Referrals'
			
	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Approach - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Approach' AS 'Disposition',
			2 AS 'GroupingCode', 
			Approach.ApproachName AS 'Type',
			SUM(CASE WHEN ReferralOrganApproachID > 1 AND ReferralOrganApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN ReferralBoneApproachID > 1 AND ReferralBoneApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueApproachID > 1 AND ReferralTissueApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN ReferralSkinApproachID > 1 AND ReferralSkinApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesApproachID > 1 AND ReferralValvesApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransApproachID > 1 AND ReferralEyesTransApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschApproachID > 1 AND ReferralEyesRschApproachID = ApproachID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry',
			@TotalAppropriateReferrals AS 'Total_Referrals'
			
	FROM 	Approach, #Temp_OutcomeByCategory_Select
	WHERE	Approach.ApproachID > 1 AND Approach.Inactive <> 1
	GROUP BY Approach.ApproachName,
			 Approach.ApproachReportDisplaySort1
	ORDER BY Approach.ApproachName

/*** End APPROACH ***/


/*** CONSENT ***/
	/* Registry Consent */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)

	SELECT
			0 AS 'FormatCode',
			'Consent' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1 = Blank
				 1 = Yes
				 3 = Not on Registry
				 5 = Not Checked
			*/
			SUM(CASE WHEN ReferralOrganConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschConsentID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry', 
			@TotalApproachReferrals AS 'Total_Referrals'

	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Consent - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, OrganReg, Bone, BoneReg, Soft_Tissue, TissueReg, Skin, SkinReg, Valves, ValvesReg, Eyes, EyesReg, Other, OtherReg,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Consent' AS 'Disposition',
			2 AS 'GroupingCode', 
			Consent.ConsentName AS 'Type',
			SUM(CASE WHEN ReferralOrganConsentID > 1 AND ReferralOrganConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN (ReferralOrganConsentID > 1 AND ReferralOrganConsentID = ConsentID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'OrganReg',
			SUM(CASE WHEN ReferralBoneConsentID > 1 AND ReferralBoneConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN (ReferralBoneConsentID > 1 AND ReferralBoneConsentID = ConsentID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'BoneReg',
			SUM(CASE WHEN ReferralTissueConsentID > 1 AND ReferralTissueConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN (ReferralTissueConsentID > 1 AND ReferralTissueConsentID = ConsentID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'TissueReg',
			SUM(CASE WHEN ReferralSkinConsentID > 1 AND ReferralSkinConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN (ReferralSkinConsentID > 1 AND ReferralSkinConsentID = ConsentID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'SkinReg',
			SUM(CASE WHEN ReferralValvesConsentID > 1 AND ReferralValvesConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN (ReferralValvesConsentID > 1 AND ReferralValvesConsentID = ConsentID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'ValvesReg',
			SUM(CASE WHEN ReferralEyesTransConsentID > 1 AND ReferralEyesTransConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN (ReferralEyesTransConsentID > 1 AND ReferralEyesTransConsentID = ConsentID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'EyesReg',
			SUM(CASE WHEN ReferralEyesRschConsentID > 1 AND ReferralEyesRschConsentID = ConsentID THEN 1 ELSE 0 END) AS 'Other',
			SUM(CASE WHEN (ReferralEyesRschConsentID > 1 AND ReferralEyesRschConsentID = ConsentID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'OtherReg',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry',
			@TotalApproachReferrals AS 'Total_Referrals'
			
	FROM 	Consent, #Temp_OutcomeByCategory_Select
	WHERE	Consent.ConsentID > 1 AND Consent.Inactive <> 1
	GROUP BY Consent.ConsentName,
			 Consent.ConsentReportDisplaySort1
	ORDER BY Consent.ConsentName
	
/*** End CONSENT ***/


/*** RECOVERY ***/
	/* Registry Recovery (Conversion) */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, Bone, Soft_Tissue, Skin, Valves, Eyes, Other,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)

	SELECT
			0 AS 'FormatCode',
			'Recovery' AS 'Disposition',
			1 AS 'GroupingCode', 
			RegistryStatusType.RegistryType AS'Type',
			/* Options used in Case Statements 
				-1=Blank, 1=Yes, 3=Not on Registry, 5=Not Checked 	*/
			SUM(CASE WHEN ReferralOrganConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Organs',
			SUM(CASE WHEN ReferralBoneConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN ReferralTissueConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Tissue',
			SUM(CASE WHEN ReferralSkinConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN ReferralValvesConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN ReferralEyesTransConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN ReferralEyesRschConversionID = 1 AND CASE WHEN RegistryStatus IN (-1, 3, 5) THEN 3 ELSE RegistryStatus END = RegistryStatusType.ID THEN 1 ELSE 0 END) AS 'Other',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry',
			@TotalConsentReferrals AS 'Total_Referrals'
			
	FROM #Temp_OutcomeByCategory_Select, @RegistryStatusType AS RegistryStatusType
	WHERE RegistryStatus Is Not Null
			AND RegistryStatusType.ID <> 5
	GROUP BY
	RegistryStatusType.RegistryType,
	RegistryStatusType.DisplayOrder
	ORDER BY RegistryStatusType.DisplayOrder

	/* Not Recovered - Ruleout IDs > 1 */
	INSERT INTO @TempCounts (FormatCode, Disposition, GroupingCode, Type, Organ, OrganReg, Bone, BoneReg, Soft_Tissue, TissueReg, Skin, SkinReg, Valves, ValvesReg, Eyes, EyesReg, Other, OtherReg,
							 Total_StateRegistry, Total_WebRegistry, Total_ManuallyFound, Total_NotRegistered, Total_DlaRegistry, Total_Referrals
							)

	SELECT	
			0 AS 'FormatCode',
			'Recovery' AS 'Disposition',
			2 AS 'GroupingCode', 
			Conversion.ConversionName AS 'Type',
			SUM(CASE WHEN ReferralOrganConversionID > 1 AND ReferralOrganConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Organ',
			SUM(CASE WHEN (ReferralOrganConversionID > 1 AND ReferralOrganConversionID = ConversionID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'OrganReg',
			SUM(CASE WHEN ReferralBoneConversionID > 1 AND ReferralBoneConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Bone',
			SUM(CASE WHEN (ReferralBoneConversionID > 1 AND ReferralBoneConversionID = ConversionID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'BoneReg',
			SUM(CASE WHEN ReferralTissueConversionID > 1 AND ReferralTissueConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Soft_Tissue',
			SUM(CASE WHEN (ReferralTissueConversionID > 1 AND ReferralTissueConversionID = ConversionID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'Soft_TissueReg',
			SUM(CASE WHEN ReferralSkinConversionID > 1 AND ReferralSkinConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Skin',
			SUM(CASE WHEN (ReferralSkinConversionID > 1 AND ReferralSkinConversionID = ConversionID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'SkinReg',
			SUM(CASE WHEN ReferralValvesConversionID > 1 AND ReferralValvesConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Valves',
			SUM(CASE WHEN (ReferralValvesConversionID > 1 AND ReferralValvesConversionID = ConversionID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'ValvesReg',
			SUM(CASE WHEN ReferralEyesTransConversionID > 1 AND ReferralEyesTransConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Eyes',
			SUM(CASE WHEN (ReferralEyesTransConversionID > 1 AND ReferralEyesTransConversionID = ConversionID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'EyesReg',
			SUM(CASE WHEN ReferralEyesRschConversionID > 1 AND ReferralEyesRschConversionID = ConversionID THEN 1 ELSE 0 END) AS 'Other',
			SUM(CASE WHEN (ReferralEyesRschConversionID > 1 AND ReferralEyesRschConversionID = ConversionID) AND RegistryStatus IN (1,2,4) THEN 1 ELSE 0 END) AS 'OtherReg',
			0 AS 'Total_StateRegistry',
			0 AS 'Total_WebRegistry',
			0 AS 'Total_ManuallyFound',
			0 AS 'Total_NotRegistered',
			0 AS 'Total_DlaRegistry',
			@TotalConsentReferrals AS 'Total_Referrals'
			
	FROM 	Conversion, #Temp_OutcomeByCategory_Select
	WHERE	Conversion.ConversionID > 1 AND Conversion.Inactive <> 1
	GROUP BY Conversion.ConversionName,
			 Conversion.ConversionReportDisplaySort1
	ORDER BY Conversion.ConversionName

/*** End RECOVERY ***/



/*** Start Totals ***/
	/*** TOTAL Referrals */
	INSERT INTO @TempCounts
	SELECT
			1 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Total Referrals' AS'Type',
			0 AS 'Organs',
			0 AS 'OrgansReg',
			0 AS 'Bone',
			0 AS 'BoneReg',
			0 AS 'Soft_Tissue',
			0 AS 'TissueReg',
			0 AS 'Skin',
			0 AS 'SkinReg',
			0 AS 'Valves',
			0 AS 'ValvesReg',
			0 AS 'Eyes',
			0 AS 'EyesReg',
			0 AS 'Other',
			0 AS 'OtherReg',
			@TotalReferralStateRegistry,
			@TotalReferralWebRegistry,
			@TotalReferralManuallyFound,
			@TotalReferralNotRegistered,
			@TotalReferralDlaRegistry,
			@TotalReferralReferrals

	/*** TOTAL Appropriate */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Appropriate' AS'Type',
			0 AS 'Organs',
			0 AS 'OrgansReg',
			0 AS 'Bone',
			0 AS 'BoneReg',
			0 AS 'Soft_Tissue',
			0 AS 'Soft_TissueReg',
			0 AS 'Skin',
			0 AS 'SkinReg',
			0 AS 'Valves',
			0 AS 'ValvesReg',
			0 AS 'Eyes',
			0 AS 'EyesReg',
			0 AS 'Other',
			0 AS 'OtherReg',
			SUM(CASE WHEN RegistryStatus = 1 AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_StateRegistry',

			SUM(CASE WHEN RegistryStatus = 2 AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_WebRegistry',

			SUM(CASE WHEN RegistryStatus = 4 AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_ManuallyFound',

			SUM(CASE WHEN RegistryStatus IN (-1, 3, 5) AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_NotRegistered',

			SUM(CASE WHEN RegistryStatus = 6 AND
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				) THEN 1 ELSE 0 END) AS 'Total_DlaRegistry',
			
			SUM(CASE WHEN 
				(ReferralOrganAppropriateID = 1
				 OR ReferralBoneAppropriateID = 1 
				 OR ReferralTissueAppropriateID = 1
				 OR ReferralSkinAppropriateID = 1 
				 OR ReferralValvesAppropriateID = 1
				 OR ReferralEyesTransAppropriateID = 1
				 OR ReferralEyesRschAppropriateID = 1
				 ) THEN 1 ELSE 0 END) AS 'Total_Referrals'
			
	FROM	#Temp_OutcomeByCategory_Select


	/*** TOTAL Approach */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Approach' AS'Type',
			0 AS 'Organs',
			0 AS 'OrgansReg',
			0 AS 'Bone',
			0 AS 'BoneReg',
			0 AS 'Soft_Tissue',
			0 AS 'Soft_TissueReg',
			0 AS 'Skin',
			0 AS 'SkinReg',
			0 AS 'Valves',
			0 AS 'ValvesReg',
			0 AS 'Eyes',
			0 AS 'EyesReg',
			0 AS 'Other',
			0 AS 'OtherReg',
			@TotalApproachStateRegistry,
			@TotalApproachWebRegistry,
			@TotalApproachManuallyFound,
			@TotalApproachNotRegistered,
			@TotalApproachDlaRegistry,
			@TotalApproachReferrals


	/*** TOTAL Consent */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Consent' AS'Type',
			0 AS 'Organs',
			0 AS 'OrgansReg',
			0 AS 'Bone',
			0 AS 'BoneReg',
			0 AS 'Soft_Tissue',
			0 AS 'Soft_TissueReg',
			0 AS 'Skin',
			0 AS 'SkinReg',
			0 AS 'Valves',
			0 AS 'ValvesReg',
			0 AS 'Eyes',
			0 AS 'EyesReg',
			0 AS 'Other',
			0 AS 'OtherReg',
			@TotalConsentStateRegistry,
			@TotalConsentWebRegistry,
			@TotalConsentManuallyFound,
			@TotalConsentNotRegistered,
			@TotalConsentDlaRegistry,
			@TotalConsentReferrals


	/*** TOTAL Recovery - Conversion */
	INSERT INTO @TempCounts
	SELECT
			0 AS 'FormatCode',
			'Totals' AS 'Disposition',
			0 AS 'GroupingCode', 
			'Recovery' AS'Type',
			0 AS 'Organs',
			0 AS 'OrgansReg',
			0 AS 'Bone',
			0 AS 'BoneReg',
			0 AS 'Soft_Tissue',
			0 AS 'Soft_TissueReg',
			0 AS 'Skin',
			0 AS 'SkinReg',
			0 AS 'Valves',
			0 AS 'ValvesReg',
			0 AS 'Eyes',
			0 AS 'EyesReg',
			0 AS 'Other',
			0 AS 'OtherReg',
			@TotalRecoveryStateRegistry AS 'Total_StateRegistry',
			@TotalRecoveryWebRegistry AS 'Total_WebRegistry',
			@TotalRecoveryManuallyFound AS 'Total_ManuallyFound',
			@TotalRecoveryNotRegistered AS 'Total_NotRegistered',
			@TotalRecoveryDlaRegistry AS 'Total_DlaRegistry',
			@TotalRecoveryReferrals AS 'Total_Referrals'
 /*** END Totals ***/
/*** End Counts  ***/


--SELECT * FROM #Temp_OutcomeByCategory_Select
SELECT * FROM @TempCounts


DROP TABLE #Temp_OutcomeByCategory_Select


GO