SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_UnitSummaryCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_UnitSummaryCount_Archive]
GO




-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_UnitSummaryCount_Archive 3, 2000
CREATE PROCEDURE spi_Referral_UnitSummaryCount_Archive

	@MonthID	int,
	@YearID		int

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
	CREATE TABLE #_Temp_Referral_UnitSummary 
	(
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[SubLocationID] [int] NULL ,
	[SubLocationLevel] [varchar](4) NULL ,	
	[AllTypes] [int] NULL  DEFAULT (0),
	[AppropriateOrgan] [int] NULL  DEFAULT (0),
	[AppropriateBone] [int] NULL  DEFAULT (0),
	[AppropriateTissue] [int] NULL  DEFAULT (0),
	[AppropriateSkin] [int] NULL  DEFAULT (0),
	[AppropriateValves] [int] NULL  DEFAULT (0),
	[AppropriateEyes] [int] NULL  DEFAULT (0),
	[AppropriateOther] [int] NULL  DEFAULT (0),
	[AppropriateAllTissue] [int] NULL  DEFAULT (0),
	[AppropriateRO] [int] NULL  DEFAULT (0)
	)

CREATE TABLE #_Temp_Referral_UnitSelect
   (
   [CallSourceCodeID] [int] NULL ,
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralCallerSubLocationID][int]NULL,  
   [ReferralCallerSubLocationLevel][VARCHAR](4) NULL,
   [ReferralOrganAppropriateID][int] NULL,
   [ReferralBoneAppropriateID][int] NULL,
   [ReferralTissueAppropriateID][int] NULL,
   [ReferralSkinAppropriateID][int] NULL,
   [ReferralValvesAppropriateID][int] NULL,
   [ReferralEyesTransAppropriateID][int] NULL,
   [ReferralEyesRschAppropriateID][int] NULL
   )

	--Clean temp table
	TRUNCATE TABLE   #_Temp_Referral_UnitSummary

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

	--Get the list of organizations
	set @strSelectLine = 'INSERT INTO #_Temp_Referral_UnitSummary'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID, SubLocationID, SubLocationLevel)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID, ReferralCallerSubLocationID, ReferralCallerSubLocationLevel'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Call'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 07/29/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID, ReferralCallerSubLocationLevel'

	EXEC(@strSelectLine+@strSelectLine2)

--Build a TempTable
            --Clean #_Temp_Referral_?Select
               TRUNCATE TABLE   #_Temp_Referral_UnitSelect
            --Insert Data into #_Temp_Referral_?Select based on month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_UnitSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralCallerSubLocationID, ReferralCallerSubLocationLevel, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID)'

	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralCallerSubLocationID, ReferralCallerSubLocationLevel, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Referral'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 07/29/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

	EXEC(@strSelectLine+@strSelectLine2)

	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AllTypes = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID, 
			ReferralCallerSubLocationLevel,
			Count(ReferralID) AS ReferralCount
	FROM		#_Temp_Referral_UnitSelect

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID, ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
	or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateOrgan = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        ReferralOrganAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateBone = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        ReferralBoneAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        ReferralTissueAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateSkin = CountTable.ReferralCount
	FROM		
	(
	SELECT 	        CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount 
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        ReferralSkinAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateValves = CountTable.ReferralCount
	FROM		
	(
	SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        ReferralValvesAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateEyes = CountTable.ReferralCount
	FROM		
	(
	SELECT 		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount 
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        ReferralEyesTransAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateOther = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount  
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        ReferralEyesRschAppropriateID = 1
	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateAllTissue = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount 
	FROM		#_Temp_Referral_UnitSelect
	WHERE	        (ReferralBoneAppropriateID = 1
	OR		ReferralTissueAppropriateID = 1
	OR		ReferralSkinAppropriateID = 1
	OR		ReferralValvesAppropriateID = 1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID


--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	UPDATE	#_Temp_Referral_UnitSummary
	SET		AppropriateRO = CountTable.ReferralCount
	FROM		
	(
	SELECT		CallSourceCodeID, ReferralCallerOrganizationID, 
			ReferralCallerSubLocationID,  
			ReferralCallerSubLocationLevel,
			Count(ReferralCallerSubLocationID) AS ReferralCount 
	FROM		#_Temp_Referral_UnitSelect
	WHERE	       (ReferralOrganAppropriateID <> 1 
	AND		ReferralBoneAppropriateID <> 1
	AND		ReferralTissueAppropriateID <> 1
	AND		ReferralSkinAppropriateID <> 1
	AND		ReferralValvesAppropriateID <> 1
	AND		ReferralEyesTransAppropriateID <>1
	AND		ReferralEyesRschAppropriateID <>1)

	GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID, ReferralCallerSubLocationID,ReferralCallerSubLocationLevel
	) AS CountTable
	WHERE		SourceCodeID = CountTable.CallSourceCodeID
	AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	AND		(SubLocationLevel = CountTable.ReferralCallerSubLocationLevel  
			or ((CountTable.ReferralCallerSubLocationLevel is null AND SublocationLevel is null)))
	AND		SubLocationID = CountTable.ReferralCallerSubLocationID

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_UnitSummaryCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_UnitSummaryCount
	SELECT * FROM #_Temp_Referral_UnitSummary 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID, SubLocationID, SubLocationLevel

	DROP TABLE #_Temp_Referral_UnitSummary
        DROP TABLE #_Temp_Referral_UnitSelect




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

