SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_ApproachPersonCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_ApproachPersonCount]
GO




CREATE  PROCEDURE [dbo].[spi_Referral_ApproachPersonCount]

	@MonthID	int,
	@YearID		int

AS
/******************************************************************************
**		File: spi_Referral_ApproachPersonCount.sql
**		Name: spi_Referral_ApproachPersonCount
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
**		10/19/2006 ccarroll - added case statements to prevent counts on referrals where service level
                        does not permit counting. StatTrac 8.0 Iteration2 release. 
**      08/01/2010	ccarroll		Updated from Production
*******************************************************************************/
 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE
	
	@ReferralCount		int,
	@DayLightStartDate   	datetime,
   	@DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     

	--Create the temp table
	CREATE TABLE #_Temp_Referral_ApproachPersonCount 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL , 
	[OrganizationID] [int] NULL ,
	[ApproachPersonID] [int] NULL ,
	[AllTypes] [int] NULL DEFAULT (0),
	[AppropriateOrgan] [int] NULL DEFAULT (0),
	[AppropriateBone] [int] NULL DEFAULT (0),
	[AppropriateTissue] [int] NULL DEFAULT (0),
	[AppropriateSkin] [int] NULL DEFAULT (0),
	[AppropriateValves] [int] NULL DEFAULT (0),
	[AppropriateEyes] [int] NULL DEFAULT (0),
	[AppropriateOther] [int] NULL DEFAULT (0),
	[AppropriateAllTissue] [int] NULL DEFAULT (0),
	[AppropriateRO] [int] NULL DEFAULT (0),
	[ApproachRO] [int] NULL DEFAULT (0)
	)
CREATE TABLE #_Temp_Referral_ApproachPersonSelect
   (
   [CallSourceCodeID] [int] NULL , 
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralApproachedByPersonID] [int] NULL ,
   [ReferralOrganAppropriateID][int] NULL,
   [ReferralBoneAppropriateID][int] NULL,
   [ReferralTissueAppropriateID][int] NULL,
   [ReferralSkinAppropriateID][int] NULL,
   [ReferralValvesAppropriateID][int] NULL,
   [ReferralEyesTransAppropriateID][int] NULL,
   [ReferralEyesRschAppropriateID][int] NULL,
   [ReferralOrganApproachID][int] NULL,
   [ReferralBoneApproachID][int] NULL,
   [ReferralTissueApproachID][int] NULL,
   [ReferralSkinApproachID][int] NULL,
   [ReferralValvesApproachID][int] NULL,
   [ReferralEyesTransApproachID][int] NULL,
   [ReferralEyesRschApproachID][int] NULL,
   )
	--Clean temp table
	TRUNCATE TABLE  #_Temp_Referral_ApproachPersonCount




	--Get the list of TimeZoneAbbreviation
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_ApproachPersonCount'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID, ApproachPersonID)'
	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(OrganizationTimeZone , CallDateTime), CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(OrganizationTimeZone , CallDateTime), CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' vwDataWarehouseCall.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID, ReferralApproachedByPersonID'

	set @strSelectLine = @strSelectLine + '	FROM vwDataWarehouseCall'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseReferral ON vwDataWarehouseReferral.CallID = vwDataWarehouseCall.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseSourceCode ON vwDataWarehouseCall.SourceCodeID = vwDataWarehouseSourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(OrganizationTimeZone , CallDateTime), CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(OrganizationTimeZone , CallDateTime), CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID'

	EXEC(@strSelectLine+@strSelectLine2)

--Build a TempTable
            --Clean #_Temp_Referral_?Select
	TRUNCATE TABLE  #_Temp_Referral_ApproachPersonSelect
            --Insert Data into #_Temp_Referral_?Select based on month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_ApproachPersonSelect'
	set @strSelectLine = @strSelectLine + ' ( CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralApproachedByPersonID, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID,'
	set @strSelectLine = @strSelectLine + ' ReferralOrganApproachID, ReferralBoneApproachID, ReferralTissueApproachID, ReferralSkinApproachID, ReferralValvesApproachID, ReferralEyesTransApproachID, ReferralEyesRschApproachID)'
	set @strSelectLine = @strSelectLine + ' SELECT vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralApproachedByPersonID, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachOrgan = -1 THEN ReferralOrganApproachID ELSE 0 END AS ReferralOrganApproachID, '
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachBone = -1 THEN ReferralBoneApproachID ELSE 0 END AS ReferralBoneApproachID,'
 	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachTissue = -1 THEN ReferralTissueApproachID ELSE 0 END AS ReferralTissueApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachSkin = -1 THEN ReferralSkinApproachID ELSE 0 END AS ReferralSkinApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachValves = -1 THEN ReferralValvesApproachID ELSE 0 END AS ReferralValvesApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesTransApproachID ELSE 0 END AS ReferralEyesTransApproachID,'
	set @strSelectLine = @strSelectLine + ' CASE WHEN ServiceLevelApproachEyes = -1 THEN ReferralEyesRschApproachID ELSE 0 END AS ReferralEyesRschApproachID'
	set @strSelectLine = @strSelectLine + '	FROM vwDataWarehouseReferral'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseCall ON vwDataWarehouseCall.CallID = vwDataWarehouseReferral.CallID'
	-- ccarroll 10/16/2006 added join to service level - StatTrac 80 Iteration2
	set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseCallCriteria ON vwDataWarehouseCallCriteria.CallID = vwDataWarehouseCall.CallID'
	set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseServiceLevel ON vwDataWarehouseServiceLevel.ServiceLevelID = vwDataWarehouseCallCriteria.ServiceLevelID'

	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseSourceCode ON vwDataWarehouseCall.SourceCodeID = vwDataWarehouseSourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(OrganizationTimeZone , CallDateTime), CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(OrganizationTimeZone , CallDateTime), CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

	EXEC(@strSelectLine+@strSelectLine2)

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AllTypes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonSelect
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE		ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE	        ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************

	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID
		
--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount  
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE		(ReferralBoneAppropriateID = 1
	OR		ReferralTissueAppropriateID = 1
	OR		ReferralSkinAppropriateID = 1
	OR		ReferralValvesAppropriateID = 1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE	        (ReferralOrganAppropriateID <> 1 
	AND		ReferralBoneAppropriateID <> 1
	AND		ReferralTissueAppropriateID <> 1
	AND		ReferralSkinAppropriateID <> 1
	AND		ReferralValvesAppropriateID <> 1
	AND		ReferralEyesTransAppropriateID <>1
	AND		ReferralEyesRschAppropriateID <>1)
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID

--************************************************************************************************************************************************************************************
	-- ApproachRO Rule Out  -- Added 11/5/04 - SAP
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_ApproachPersonCount
	SET		AppropriateRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralApproachedByPersonID,  
			Count(ReferralApproachedByPersonID) AS ReferralCount 
	FROM		#_Temp_Referral_ApproachPersonSelect
	WHERE	        (ReferralOrganApproachID NOT IN (1,12,13)
	AND		ReferralBoneApproachID NOT IN (1,12,13)
	AND		ReferralTissueApproachID NOT IN (1,12,13)
	AND		ReferralSkinApproachID NOT IN (1,12,13)
	AND		ReferralValvesApproachID NOT IN (1,12,13)
	AND		ReferralEyesTransApproachID NOT IN (1,12,13)
	AND		ReferralEyesRschApproachID NOT IN (1,12,13))
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralApproachedByPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		ApproachPersonID = CountTable.ReferralApproachedByPersonID
--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_ApproachPersonCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_ApproachPersonCount
	SELECT * FROM #_Temp_Referral_ApproachPersonCount 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID, ApproachPersonID
	
	--SELECT * FROM #_Temp_Referral_ApproachPersonCount
	DROP TABLE #_Temp_Referral_ApproachPersonCount
	DROP TABLE #_Temp_Referral_ApproachPersonSelect




GO


