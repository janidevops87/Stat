SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_TypeCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_TypeCount_Archive]
GO





-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_TypeCount_Archive 3, 2000
CREATE PROCEDURE spi_Referral_TypeCount_Archive

	@MonthID		int,
	@YearID			int

AS

DECLARE
	
	@ReferralCount		int,
	@DayLightStartDate   	datetime,
	@DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT

	--Create the temp table
	CREATE TABLE #_Temp_Referral_TypeCount 
	(
	[YearID] [int] NOT NULL ,
	[MonthID] [int] NOT NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[OrganizationID] [int] NOT NULL ,
	[AllTypes] [int] NULL DEFAULT (0),
	[OTEType] [int] NULL DEFAULT (0),
	[TEType] [int] NULL DEFAULT (0),
	[EType] [int] NULL DEFAULT (0),
	[ROType] [int] NULL DEFAULT (0),
	[AgeROType] [int] NULL DEFAULT (0),
	[MedROType] [int] NULL DEFAULT (0),
	[RegistryType] [int] NULL DEFAULT (0),
	[AppropriateOrgan] [int] NULL DEFAULT (0),
	[AppropriateBone] [int] NULL DEFAULT (0),
	[AppropriateTissue] [int] NULL DEFAULT (0),
	[AppropriateSkin] [int] NULL DEFAULT (0),
	[AppropriateValves] [int] NULL DEFAULT (0),
	[AppropriateEyes] [int] NULL DEFAULT (0),
	[AppropriateOther] [int] NULL DEFAULT (0),
	
       	 [ApproachOrgan] [int] NULL DEFAULT (0),
	[ApproachBone] [int] NULL DEFAULT (0),
	[ApproachTissue] [int] NULL DEFAULT (0),
	[ApproachSkin] [int] NULL DEFAULT (0),
	[ApproachValves] [int] NULL DEFAULT (0),
	[ApproachEyes] [int] NULL DEFAULT (0),
	[ApproachOther] [int] NULL DEFAULT (0),

	[ConsentOrgan] [int] NULL DEFAULT (0),
	[ConsentBone] [int] NULL DEFAULT (0),
	[ConsentTissue] [int] NULL DEFAULT (0),
	[ConsentSkin] [int] NULL DEFAULT (0),
	[ConsentValves] [int] NULL DEFAULT (0),
	[ConsentEyes] [int] NULL DEFAULT (0),
	[ConsentOther] [int] NULL DEFAULT (0),

	[RecoveryOrgan] [int] NULL DEFAULT (0),
	[RecoveryBone] [int] NULL DEFAULT (0),
	[RecoveryTissue] [int] NULL DEFAULT (0),
	[RecoverySkin] [int] NULL DEFAULT (0),
	[RecoveryValves] [int] NULL DEFAULT (0),
	[RecoveryEyes] [int] NULL DEFAULT (0),
	[RecoveryOther] [int] NULL DEFAULT (0),

	[AppropriateAllTissue] [int] NULL DEFAULT (0),
	[ApproachAllTissue] [int] NULL DEFAULT (0),
	[ConsentAllTissue] [int] NULL DEFAULT (0),
	[RecoveryAllTissue] [int] NULL DEFAULT (0),
	[AnyAppropriate] [int] NULL DEFAULT (0),
   
   	--drh 3/1/02
   	[Approach_Reg] [int] NULL DEFAULT (0)

	)

CREATE TABLE #_Temp_Referral_TypeSelect
   (
   [CallSourceCodeID] [int] NULL , 
   [ReferralCallerOrganizationID] [int] NULL , 
   [ReferralID] [int] NULL , 
   [ReferralTypeID] [int] NULL ,
   [ReferralOrganAppropriateID] [int] NULL ,
   [ReferralOrganApproachID] [int] NULL ,
   [ReferralOrganConsentID] [int] NULL ,
   [ReferralOrganConversionID] [int] NULL ,
   [ReferralBoneAppropriateID] [int] NULL ,
   [ReferralBoneApproachID] [int] NULL ,
   [ReferralBoneConsentID] [int] NULL ,
   [ReferralBoneConversionID] [int] NULL ,
   [ReferralTissueAppropriateID] [int] NULL ,
   [ReferralTissueApproachID] [int] NULL ,
   [ReferralTissueConsentID] [int] NULL ,
   [ReferralTissueConversionID] [int] NULL ,
   [ReferralSkinAppropriateID] [int] NULL ,
   [ReferralSkinApproachID] [int] NULL ,
   [ReferralSkinConsentID] [int] NULL ,
   [ReferralSkinConversionID] [int] NULL ,
   [ReferralEyesTransAppropriateID] [int] NULL ,
   [ReferralEyesTransApproachID] [int] NULL ,
   [ReferralEyesTransConsentID] [int] NULL ,
   [ReferralEyesTransConversionID] [int] NULL ,
   [ReferralEyesRschAppropriateID] [int] NULL ,
   [ReferralEyesRschApproachID] [int] NULL ,
   [ReferralEyesRschConsentID] [int] NULL ,
   [ReferralEyesRschConversionID] [int] NULL ,
   [ReferralValvesAppropriateID] [int] NULL ,
   [ReferralValvesApproachID] [int] NULL ,
   [ReferralValvesConsentID] [int] NULL ,
   [ReferralValvesConversionID] [int] NULL ,
   [DonorRegistryType] [int] NULL,
   
   --drh 3/1/02
   [ReferralApproachTypeId] [int] NULL

   )
	--Clean temp table
	DELETE #_Temp_Referral_TypeCount

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_TypeCount'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Call'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)
	
--Build a TempTable
            --Clean #_Temp_Referral_?Select
               DELETE #_Temp_Referral_TypeSelect
            --Insert Data into #_Temp_Referral_?Select based on month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_TypeSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralTypeID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID, ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, DonorRegistryType, ReferralApproachTypeId)'

	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralTypeID, ReferralOrganAppropriateID, ReferralOrganApproachID, ReferralOrganConsentID, ReferralOrganConversionID, ReferralBoneAppropriateID, ReferralBoneApproachID, ReferralBoneConsentID, ReferralBoneConversionID, ReferralTissueAppropriateID, ReferralTissueApproachID, ReferralTissueConsentID, ReferralTissueConversionID, ReferralSkinAppropriateID, ReferralSkinApproachID, ReferralSkinConsentID, ReferralSkinConversionID, ReferralEyesTransAppropriateID, ReferralEyesTransApproachID, ReferralEyesTransConsentID, ReferralEyesTransConversionID, ReferralEyesRschAppropriateID, ReferralEyesRschApproachID,  ReferralEyesRschConsentID, ReferralEyesRschConversionID, ReferralValvesAppropriateID, ReferralValvesApproachID, ReferralValvesConsentID, ReferralValvesConversionID, DonorRegistryType, ReferralApproachTypeId'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Referral'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

	EXEC(@strSelectLine+@strSelectLine2)

	-- update the count stats

/****************************************************************************************************************************************************************************************/
	-- All Referrals Count
/****************************************************************************************************************************************************************************************/
	UPDATE	#_Temp_Referral_TypeCount
	SET		AllTypes = CountTable.ReferralCount
	FROM		

	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_TypeSelect
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


/****************************************************************************************************************************************************************************************/
	-- OTE Count
/****************************************************************************************************************************************************************************************/
	UPDATE	        #_Temp_Referral_TypeCount
	SET		OTEType = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_TypeSelect
	WHERE	        ReferralTypeID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- TE Count
/****************************************************************************************************************************************************************************************/
	UPDATE	        #_Temp_Referral_TypeCount
	SET		TEType = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_TypeSelect
	WHERE	        ReferralTypeID = 2
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- E Count
/****************************************************************************************************************************************************************************************/
	UPDATE	        #_Temp_Referral_TypeCount
	SET		EType = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM		#_Temp_Referral_TypeSelect
	WHERE	        ReferralTypeID = 3
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- Ruleout Count
/****************************************************************************************************************************************************************************************/
	UPDATE	  #_Temp_Referral_TypeCount
	SET	  ROType = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralTypeID = 4
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- Age Ruleout Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AgeROType = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralTypeID = 4
	AND	   ReferralBoneAppropriateID <> 4
	AND        ReferralBoneAppropriateID <> 3
	AND	   ReferralTissueAppropriateID <> 4
	AND	   ReferralTissueAppropriateID <> 3
	AND	   ReferralSkinAppropriateID <> 4
	AND	   ReferralSkinAppropriateID <> 3
	AND	   ReferralValvesAppropriateID <> 4
	AND	   ReferralValvesAppropriateID <> 3
	AND	   ReferralEyesTransAppropriateID <> 4
	AND	   ReferralEyesTransAppropriateID <> 3
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- Med Ruleout Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   MedROType = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralTypeID = 4
	AND	   (ReferralBoneAppropriateID = 4
	        OR 	ReferralBoneAppropriateID = 3
		OR	ReferralTissueAppropriateID = 4
		OR	ReferralTissueAppropriateID = 3
		OR	ReferralSkinAppropriateID = 4
		OR	ReferralSkinAppropriateID = 3
		OR	ReferralValvesAppropriateID = 4
		OR	ReferralValvesAppropriateID = 3
		OR	ReferralEyesTransAppropriateID = 4
		OR	ReferralEyesTransAppropriateID = 3)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateOrgan Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateOrgan = CountTable.ReferralCount
	FROM		
	(

	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateBone Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateSkin Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateValves Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateEyes Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateOther Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateOther = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AppropriateAllTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AppropriateAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   (ReferralBoneAppropriateID = 1
		OR	ReferralTissueAppropriateID = 1
		OR	ReferralSkinAppropriateID = 1
		OR	ReferralValvesAppropriateID = 1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ApproachOrgan Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ApproachOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralOrganApproachID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ApproachBone Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ApproachBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralBoneApproachID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ApproachTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralTissueApproachID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


/****************************************************************************************************************************************************************************************/
	-- ApproachSkin Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ApproachSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralSkinApproachID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ApproachValves Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ApproachValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralValvesApproachID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ApproachEyes Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ApproachEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesTransApproachID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ApproachOther Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesRschApproachID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ApproachAllTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
   	SET	   ApproachAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   (ReferralBoneApproachID = 1
		OR	ReferralTissueApproachID = 1
		OR	ReferralSkinApproachID = 1
		OR	ReferralValvesApproachID = 1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ConsentOrgan Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralOrganConsentID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ConsentBone Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralBoneConsentID = 1


	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ConsentTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralTissueConsentID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


/****************************************************************************************************************************************************************************************/
	-- ConsentSkin Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralSkinConsentID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ConsentValves Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralValvesConsentID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ConsentEyes Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesTransConsentID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ConsentOther Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentOther = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesRschConsentID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID

	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- ConsentAllTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   ConsentAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   (ReferralBoneConsentID = 1
		OR	ReferralTissueConsentID = 1
		OR	ReferralSkinConsentID = 1
		OR	ReferralValvesConsentID = 1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- RecoveryOrgan Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoveryOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralOrganConversionID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- RecoveryBone Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoveryBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralBoneConversionID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- RecoveryTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoveryTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralTissueConversionID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID


/****************************************************************************************************************************************************************************************/
	-- RecoverySkin Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoverySkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralSkinConversionID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- RecoveryValves Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoveryValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralValvesConversionID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	--RecoveryEyes Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoveryEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesTransConversionID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- RecoveryOther Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoveryOther = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   ReferralEyesRschConversionID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- RecoveryAllTissue Count
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RecoveryAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   (ReferralBoneConversionID = 1
		OR	ReferralTissueConversionID = 1
		OR	ReferralSkinConversionID = 1
		OR	ReferralValvesConversionID = 1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS       CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- AnyAppropriate
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   AnyAppropriate = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   (ReferralOrganAppropriateID = 1
		OR	ReferralBoneAppropriateID = 1
		OR	ReferralTissueAppropriateID = 1
		OR	ReferralSkinAppropriateID = 1
		OR	ReferralEyesTransAppropriateID = 1
		OR	ReferralEyesRschAppropriateID =1 
		OR	ReferralValvesAppropriateID = 1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS       CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- DonorRegType
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   RegistryType = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	   (DonorRegistryType = 1
		OR	DonorRegistryType = 2)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS       CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	--Approach_Reg
/****************************************************************************************************************************************************************************************/
	UPDATE	   #_Temp_Referral_TypeCount
	SET	   Approach_Reg = CountTable.ReferralCount
	FROM		
	(
	SELECT 	         CallSourceCodeID, ReferralCallerOrganizationID, Count(ReferralCallerOrganizationID) AS ReferralCount
	FROM	   #_Temp_Referral_TypeSelect
	WHERE	ReferralApproachTypeId = 8

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	) AS       CountTable
	WHERE	SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

/****************************************************************************************************************************************************************************************/
	-- Transfer to table
/****************************************************************************************************************************************************************************************/

	-- Delete any records for the given month and year
	DELETE 	Referral_TypeCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_TypeCount
	SELECT * FROM #_Temp_Referral_TypeCount 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID

       -- SELECT * from #_Temp_Referral_TypeCount 
	DROP TABLE #_Temp_Referral_TypeCount
	DROP TABLE #_Temp_Referral_TypeSelect










































































GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

