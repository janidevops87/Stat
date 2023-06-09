SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ApproachPersonConsentCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ApproachPersonConsentCount_Archive]
GO



CREATE PROCEDURE [dbo].[spi_Referral_ApproachPersonConsentCount_Archive]

	@MonthID	int,
	@YearID		int
	
AS
/******************************************************************************
**		File: spi_Referral_ApproachPersonConsentCount_Archive.sql
**		Name: spi_Referral_ApproachPersonConsentCount_Archive
**		Desc: 
**              
**		Return values:
** 
**		Called by: DataWarehouse  
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll  
**		Date: 08/01/2011
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------		-------------------------------------------
**      08/01/2010	ccarroll		Updated from Production
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE
	
	@ReferralConsentCount		int,
	@DayLightStartDate   		datetime,
   	@DayLightEndDate     		datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)


  Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT

	--Create the temp table
	CREATE TABLE #_Temp_Referral_ApproachPersonConsentCount 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[ApproachPersonID] [int] NULL ,
	[TotalApproached] [int] NULL DEFAULT (0),
	[ConsentOrgan] [int] NULL DEFAULT (0),
	[ConsentBone] [int] NULL DEFAULT (0),
	[ConsentTissue] [int] NULL DEFAULT (0),
	[ConsentSkin] [int] NULL DEFAULT (0),
	[ConsentValves] [int] NULL DEFAULT (0),
	[ConsentEyes] [int] NULL DEFAULT (0),
	[ConsentOther] [int] NULL DEFAULT (0),
	[ConsentAllTissue] [int] NULL DEFAULT (0),
	[ApproachOrgan] [int] NULL DEFAULT (0),
	[ApproachBone] [int] NULL DEFAULT (0),
	[ApproachTissue] [int] NULL DEFAULT (0),
	[ApproachSkin] [int] NULL DEFAULT (0),
	[ApproachValves] [int] NULL DEFAULT (0),
	[ApproachEyes] [int] NULL DEFAULT (0),
	[ApproachOther] [int] NULL DEFAULT (0),
	[ApproachAllTissue] [int] NULL DEFAULT (0)
	)
CREATE TABLE #_Temp_Referral_ApproachPersonConsentSelect
   (
   [CallSourceCodeID] [int] NULL , 
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralApproachedByPersonID] [int] NULL ,
   [ReferralOrganConsentID][int] NULL,
   [ReferralBoneConsentID][int] NULL,
   [ReferralTissueConsentID][int] NULL,
   [ReferralSkinConsentID][int] NULL,
   [ReferralValvesConsentID][int] NULL,
   [ReferralEyesTransConsentID][int] NULL,
   [ReferralEyesRschConsentID][int] NULL,
   [ReferralOrganApproachID][int] NULL,
   [ReferralBoneApproachID][int] NULL,
   [ReferralTissueApproachID][int] NULL,
   [ReferralSkinApproachID][int] NULL,
   [ReferralValvesApproachID][int] NULL,
   [ReferralEyesTransApproachID][int] NULL,
   [ReferralEyesRschApproachID][int] NULL,
   [RegistryStatus][int] NULL
   )
	--Clean temp table
	TRUNCATE TABLE  #_Temp_Referral_ApproachPersonConsentCount

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ApproachPersonConsentCount (YearID, MonthID, SourceCodeID, OrganizationID, ApproachPersonID)'
	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID, ReferralApproachedByPersonID'
	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Call' 
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))
	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID'

	EXEC(@strSelectLine+@strSelectLine2)

--Build a TempTable
            --Clean #_Temp_Referral_?Select
	TRUNCATE TABLE  #_Temp_Referral_ApproachPersonConsentSelect
            --Insert Data into #_Temp_Referral_?Select based on month and year
		set @strSelectLine = 'INSERT #_Temp_Referral_ApproachPersonConsentSelect (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralApproachedByPersonID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID, ReferralEyesRschConsentID,'
		set @strSelectLine = @strSelectLine + ' ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralEyesRschApproachID, RegistryStatus)'
		set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralApproachedByPersonID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID, ReferralEyesRschConsentID,'
		set @strSelectLine = @strSelectLine + ' ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralEyesRschApproachID, '
		set @strSelectLine = @strSelectLine + ' CASE _ReferralProdArchive.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus'
		set @strSelectLine = @strSelectLine + ' FROM _ReferralProdArchive.dbo.Referral'
		set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID'
		set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
		set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
		set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
		set @strSelectLine = @strSelectLine + '	LEFT JOIN _ReferralProdArchive.dbo.RegistryStatus ON _ReferralProdArchive.dbo.Referral.CallId = _ReferralProdArchive.dbo.RegistryStatus.CallId'

		set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
		set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))
		set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

		EXEC(@strSelectLine+@strSelectLine2)

	-- update the ConsentCount stats

--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		TotalApproached = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ConsentOrgan
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralOrganConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ConsentBone
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE	        ReferralBoneConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ConsentTissue
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralTissueConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ConsentSkin
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralSkinConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID
		
--**************************************************************************************************************************************************************************************
	-- ConsentValves 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralValvesConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ConsentEyes

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralEyesTransConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ConsentOther

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralEyesRschConsentID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ConsentAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ConsentAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		(ReferralBoneConsentID = 1
	OR		ReferralTissueConsentID = 1
	OR		ReferralSkinConsentID = 1
	OR		ReferralValvesConsentID = 1)
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOrgan
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralOrganApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachBone
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE	        ReferralBoneApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachTissue
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralTissueApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachSkin
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralSkinApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID
		
--**************************************************************************************************************************************************************************************
	-- ApproachValves 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralValvesApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachEyes

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralEyesTransApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachOther

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		ReferralEyesRschApproachID = 1
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- ApproachAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonConsentCount
	SET		ApproachAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonConsentSelect
	WHERE		(ReferralBoneApproachID = 1
	OR		ReferralTissueApproachID = 1
	OR		ReferralSkinApproachID = 1
	OR		ReferralValvesApproachID = 1)
	AND		RegistryStatus = 0
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************



	-- Delete any records for the given month and year
	DELETE 	Referral_ApproachPersonConsentCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_ApproachPersonConsentCount
	SELECT * FROM #_Temp_Referral_ApproachPersonConsentCount 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID, ApproachPersonID
	
	
        DROP TABLE #_Temp_Referral_ApproachPersonConsentCount
	DROP TABLE #_Temp_Referral_ApproachPersonConsentSelect
GO


