SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ApproachPersonConsentCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ApproachPersonConsentCount]
GO



CREATE    PROCEDURE [dbo].[spi_Referral_ApproachPersonConsentCount]

	@MonthID	int,
	@YearID		int
	
AS
/******************************************************************************
**		File: spi_Referral_ApproachPersonConsentCount.sql
**		Name: spi_Referral_ApproachPersonConsentCount
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
/* ccarroll 10/19/2006 - added case statements to prevent counts on referrals where service level
                        does not permit counting. StatTrac 8.0 Iteration2 release. */
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE
	
	@ReferralConsentCount		int,
	@DayLightStartDate   		datetime,
   	@DayLightEndDate     		datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)


  

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




	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ApproachPersonConsentCount (YearID, MonthID, SourceCodeID, OrganizationID, ApproachPersonID)'
	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' vwDataWarehouseCall.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID, ReferralApproachedByPersonID'
	set @strSelectLine = @strSelectLine + '	FROM vwDataWarehouseCall' 
	set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseReferral ON vwDataWarehouseReferral.CallID = vwDataWarehouseCall.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseSourceCode ON vwDataWarehouseCall.SourceCodeID = vwDataWarehouseSourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID'

	EXEC(@strSelectLine+@strSelectLine2)

--Build a TempTable
            --Clean #_Temp_Referral_?Select
	TRUNCATE TABLE  #_Temp_Referral_ApproachPersonConsentSelect
            --Insert Data into #_Temp_Referral_?Select based on month and year
	    -- ccarroll 10/19/2006 - added case statements to prevent counts on referrals where service level
	    -- does not permit counting. StatTrac 8.0 Iteration2 release. 

		set @strSelectLine = 'INSERT #_Temp_Referral_ApproachPersonConsentSelect (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralApproachedByPersonID, ReferralOrganConsentID, ReferralBoneConsentID, ReferralTissueConsentID, ReferralSkinConsentID, ReferralValvesConsentID, ReferralEyesTransConsentID, ReferralEyesRschConsentID,'
		set @strSelectLine = @strSelectLine + ' ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralEyesRschApproachID, RegistryStatus)'
		set @strSelectLine = @strSelectLine + ' SELECT vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralApproachedByPersonID, '
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentOrgan = -1 THEN ReferralOrganConsentID ELSE 0 END AS ReferralOrganConsentID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentBone = -1 THEN ReferralBoneConsentID ELSE 0 END ReferralBoneConsentID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentTissue = -1 THEN ReferralTissueConsentID ELSE 0 END AS ReferralTissueConsentID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentSkin = -1 THEN ReferralSkinConsentID ELSE 0 END AS ReferralSkinConsentID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentValves = -1 THEN ReferralValvesConsentID ELSE 0 END AS ReferralValvesConsentID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesTransConsentID ELSE 0 END AS ReferralEyesTransConsentID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelConsentEyes = -1 THEN ReferralEyesRschConsentID ELSE 0 END AS ReferralEyesRschConsentID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachOrgan = -1 THEN ReferralOrganApproachID ELSE 0 END AS ReferralOrganApproachID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachBone = -1 THEN ReferralBoneApproachID ELSE 0 END AS ReferralBoneApproachID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachTissue = -1 THEN ReferralTissueApproachID ELSE 0 END AS ReferralTissueApproachID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachSkin = -1 THEN ReferralSkinApproachID ELSE 0 END AS ReferralSkinApproachID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachValves = -1 THEN ReferralValvesApproachID ELSE 0 END AS ReferralValvesApproachID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesTransApproachID ELSE 0 END AS ReferralEyesTransApproachID,'
		set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesRschApproachID ELSE 0 END AS ReferralEyesRschApproachID,'
		set @strSelectLine = @strSelectLine + ' CASE vwDataWarehouseRegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus'
		set @strSelectLine = @strSelectLine + ' FROM vwDataWarehouseReferral'
		set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseCall ON vwDataWarehouseCall.CallID = vwDataWarehouseReferral.CallID'
		-- ccarroll 10/19/2006 added join to service level - StatTrac 80 Iteration2
		set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseCallCriteria ON vwDataWarehouseCallCriteria.CallID = vwDataWarehouseCall.CallID'
		set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseServiceLevel ON vwDataWarehouseServiceLevel.ServiceLevelID = vwDataWarehouseCallCriteria.ServiceLevelID'

		set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseSourceCode ON vwDataWarehouseCall.SourceCodeID = vwDataWarehouseSourceCode.SourceCodeID'
		set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID'
		set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID'

		set @strSelectLine = @strSelectLine + '	LEFT JOIN vwDataWarehouseRegistryStatus ON vwDataWarehouseReferral.CallId = vwDataWarehouseRegistryStatus.CallId'

		set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = '+ltrim(str(@YearID))
		set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = ' + ltrim(str(@MonthID))
		set @strSelectLine2 = @strSelectLine2 + ' ORDER BY vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

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


