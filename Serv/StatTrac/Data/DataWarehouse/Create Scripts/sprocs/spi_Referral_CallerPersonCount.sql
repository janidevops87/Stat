SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_CallerPersonCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_CallerPersonCount]
GO





-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_CallerPersonCount 3, 2000
CREATE PROCEDURE spi_Referral_CallerPersonCount

	@MonthID		int,
	@YearID		int

AS

DECLARE
	
	@ReferralCount		int,
	@DayLightStartDate   	datetime,
	@DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     

	--Create the temp table
	CREATE TABLE #_Temp_Referral_CallerPersonCount 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[CallerPersonID] [int] NULL ,
	[AllTypes] [int] NULL  DEFAULT (0),
	[AppropriateOrgan] [int] NULL  DEFAULT (0),
	[AppropriateBone] [int] NULL  DEFAULT (0),
	[AppropriateTissue] [int] NULL  DEFAULT (0),
	[AppropriateSkin] [int] NULL  DEFAULT (0),
	[AppropriateValves] [int] NULL  DEFAULT (0),
	[AppropriateEyes] [int] NULL  DEFAULT (0),
	[AppropriateOther] [int] NULL  DEFAULT (0),
	[AppropriateAllTissue] [int] NULL  DEFAULT (0),
	[AppropriateRO] [int] NULL  DEFAULT (0),
	)

CREATE TABLE #_Temp_Referral_CallerPersonSelect
   (
   [CallSourceCodeID] [int] NULL ,
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralCallerPersonID] [int] NULL ,
   [ReferralOrganAppropriateID][int] NULL,
   [ReferralBoneAppropriateID][int] NULL,
   [ReferralTissueAppropriateID][int] NULL,
   [ReferralSkinAppropriateID][int] NULL,
   [ReferralValvesAppropriateID][int] NULL,
   [ReferralEyesTransAppropriateID][int] NULL,
   [ReferralEyesRschAppropriateID][int] NULL
   )

	--Clean temp table
	TRUNCATE TABLE   #_Temp_Referral_CallerPersonCount




	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_CallerPersonCount'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID, CallerPersonID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' vwDataWarehouseCall.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID, ReferralCallerPersonID'

	set @strSelectLine = @strSelectLine + '	FROM vwDataWarehouseCall'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseReferral ON vwDataWarehouseReferral.CallID = vwDataWarehouseCall.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseSourceCode ON vwDataWarehouseCall.SourceCodeID = vwDataWarehouseSourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID'
				-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID'

	EXEC(@strSelectLine+@strSelectLine2)
	
--Build a TempTable
            --Clean #_Temp_Referral_?Select
               TRUNCATE TABLE   #_Temp_Referral_CallerPersonSelect

        --Insert Data into #_Temp_Referral_?Select based on month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_CallerPersonSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralCallerPersonID, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID)'

	set @strSelectLine = @strSelectLine + ' SELECT vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralCallerPersonID, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID'

	set @strSelectLine = @strSelectLine + '	FROM vwDataWarehouseReferral'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseCall ON vwDataWarehouseCall.CallID = vwDataWarehouseReferral.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseSourceCode ON vwDataWarehouseCall.SourceCodeID = vwDataWarehouseSourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID'
				-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

	EXEC(@strSelectLine+@strSelectLine2)        

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AllTypes = CountTable.ReferralCount
	FROM		
	(
	SELECT 	      CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM	      #_Temp_Referral_CallerPersonSelect
	GROUP BY      CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM	#_Temp_Referral_CallerPersonSelect
	WHERE	ReferralOrganAppropriateID = 1
	GROUP BY CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE	ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE		ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID
		
--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE		ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE		ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE		ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateOther = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE		ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE		(ReferralBoneAppropriateID = 1
	OR		ReferralTissueAppropriateID = 1
	OR		ReferralSkinAppropriateID = 1
	OR		ReferralValvesAppropriateID = 1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_CallerPersonCount
	SET		AppropriateRO = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID, Count(ReferralCallerPersonID) AS ReferralCount
	FROM		#_Temp_Referral_CallerPersonSelect
	WHERE	(ReferralOrganAppropriateID <> 1 
	AND		ReferralBoneAppropriateID <> 1
	AND		ReferralTissueAppropriateID <> 1
	AND		ReferralSkinAppropriateID <> 1
	AND		ReferralValvesAppropriateID <> 1
	AND		ReferralEyesTransAppropriateID <>1
	AND		ReferralEyesRschAppropriateID <>1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerPersonID
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID	
	AND		CallerPersonID = CountTable.ReferralCallerPersonID

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_CallerPersonCount
	WHERE 	MonthID = @MonthID
	AND		YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_CallerPersonCount
	SELECT * FROM #_Temp_Referral_CallerPersonCount 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID, CallerPersonID

	--Select * from #_Temp_Referral_CallerPersonCount

	DROP TABLE #_Temp_Referral_CallerPersonCount
        DROP TABLE #_Temp_Referral_CallerPersonSelect


















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

