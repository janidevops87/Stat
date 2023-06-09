SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_AgeDemoCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_AgeDemoCount]
GO


CREATE PROCEDURE [dbo].[spi_Referral_AgeDemoCount]
   @MonthID	int,
   @YearID	int

AS
/******************************************************************************
**		File: spi_Referral_AgeDemoCount.sql
**		Name: spi_Referral_AgeDemoCount
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
   
   @ReferralCount	int,
   @CurrentAgeRangeID	int,
   @CurrentAgeStart	int,
   @CurrentAgeEnd	int, 
   @DayLightStartDate   datetime,
   @DayLightEndDate     datetime,
   @maxAgeRangeID	int,
   @strSelectLine	varchar(8000),
   @strSelectLine2	varchar(8000),
   @strTemp		varchar(2000)

-- set @maxAgeRangeID
SELECT @maxAgeRangeID = MAX(AgeRangeID) + 1 FROM AgeRange	
SELECT @maxAgeRangeID

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
--Create the temp table
CREATE TABLE #_Temp_Referral_AgeDemo 
   (
   [YearID] [int] NULL ,
   [MonthID] [int] NULL ,
   [SourceCodeID] [int] NULL ,
   [OrganizationID] [int] NULL ,
   [DonorGender] [char](1) NULL ,
   [AgeRangeID] [int] NULL ,	
   [AllTypes] [int] NULL  DEFAULT (0),
   [AppropriateOrgan] [int] NULL  DEFAULT (0),
   [AppropriateBone] [int] NULL  DEFAULT (0),
   [AppropriateTissue] [int] NULL  DEFAULT (0),
   [AppropriateSkin] [int] NULL  DEFAULT (0),
   [AppropriateValves] [int] NULL  DEFAULT (0),
   [AppropriateEyes] [int] NULL  DEFAULT (0),
   [AppropriateOther] [int] NULL  DEFAULT (0),
   [AppropriateAllTissue] [int] NULL  DEFAULT (0),
   [AppropriateRO] [int] NULL  DEFAULT (0) ,
   [AverageAge] [int] NULL  DEFAULT (0) ,

   --2/8/02 drh
   [AllTypes_Reg] [int] NULL Default (0) ,
   [AppropriateOrgan_Reg] [int] NULL Default (0) ,
   [AppropriateBone_Reg] [int] NULL Default (0)  ,
   [AppropriateTissue_Reg] [int] NULL Default (0) ,
   [AppropriateSkin_Reg] [int] NULL Default (0)  ,
   [AppropriateValves_Reg] [int] NULL Default (0) ,
   [AppropriateEyes_Reg] [int] NULL Default (0)  ,
   [AppropriateOther_Reg] [int] NULL Default (0) ,
   [AppropriateAllTissue_Reg] [int] NULL Default (0)  ,
   [AppropriateRO_Reg] [int] NULL Default (0),
   [AverageAge_Reg] [int] NULL  DEFAULT (0) 

   )

CREATE TABLE #_Temp_Referral_AgeSelect
   (
   [CallSourceCodeID] [int] NULL , 
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralOrganAppropriateID][int] NULL,
   [ReferralBoneAppropriateID][int] NULL,
   [ReferralTissueAppropriateID][int] NULL,
   [ReferralSkinAppropriateID][int] NULL,
   [ReferralValvesAppropriateID][int] NULL,
   [ReferralEyesTransAppropriateID][int] NULL,
   [ReferralEyesRschAppropriateID][int] NULL,
   [ReferralDonorGender][char](1) NULL,

   --2/8/02 drh
   [ReferralApproachTypeID][int] NULL,
   --9/17/04 - SAP
   [RegistryStatus][int] NULL
   )
	
--Clean temp table
TRUNCATE TABLE #_Temp_Referral_AgeDemo

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

SET @CurrentAgeRangeID = 1
SET @CurrentAgeStart= (Select AgeRangeStart From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)
SET @CurrentAgeEnd= (Select AgeRangeEnd From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)

While @CurrentAgeRangeID < @maxAgeRangeID
   Begin
	--tRUNCATE TABLE #_Temp_Referral_AgeDemo
	TRUNCATE TABLE #_Temp_Referral_AgeDemo
      --Get the list of organizations
	set @strSelectLine = 'INSERT #_Temp_Referral_AgeDemo'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID, DonorGender, AgeRangeID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdReport.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID , ReferralDonorGender, AgeRangeID'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdReport.dbo.Call'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdReport.dbo.Referral ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'

	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProd_DataWarehouse.dbo.AgeRange ON _ReferralProd_DataWarehouse.dbo.AgeRange.AgeRangeID = _ReferralProd_DataWarehouse.dbo.AgeRange.AgeRangeID'

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' AND AgeRangeID = '+ltrim(str(@CurrentAgeRangeID))
	--AND   ReferralDonorGender = @DonorGender
	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorGender is not null'
	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorAgeUnit <> '+char(39)+char(39)
	set @strSelectLine2 = @strSelectLine2 + ' AND ((cast(ReferralDonorAge as Int) >= '+ltrim(str(@CurrentAgeStart))
	set @strSelectLine2 = @strSelectLine2 + 	' AND cast(ReferralDonorAge as Int) <= '+ltrim(str(@CurrentAgeEnd))
	set @strSelectLine2 = @strSelectLine2 + 	' AND ReferralDonorAgeUnit = '+char(39)+'Years'+char(39)+')'
	set @strSelectLine2 = @strSelectLine2 + ' OR (cast(ReferralDonorAge as Int) >= '+ltrim(str(@CurrentAgeStart * 365))
	set @strSelectLine2 = @strSelectLine2 + 	' AND cast(ReferralDonorAge as Int) <= '+ltrim(str(@CurrentAgeEnd * 365))
	set @strSelectLine2 = @strSelectLine2 + 	' AND ReferralDonorAgeUnit = '+char(39)+'Days'+char(39)+')'
	set @strSelectLine2 = @strSelectLine2 + ' OR (cast(ReferralDonorAge as Int)>= '+ltrim(str(@CurrentAgeStart * 12))
	set @strSelectLine2 = @strSelectLine2 + 	' AND cast(ReferralDonorAge as Int) <= '+ltrim(str(@CurrentAgeEnd * 12))
	set @strSelectLine2 = @strSelectLine2 + 	' AND ReferralDonorAgeUnit = '+char(39)+'Months'+char(39)+'))'

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID , AgeRangeID'

	EXEC(@strSelectLine+@strSelectLine2)

	--SELECT * FROM #_Temp_Referral_AgeDemo

      --SET @CurrentAgeRangeID = @CurrentAgeRangeID + 1
      --SET @CurrentAgeStart= (Select AgeRangeStart From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)
      --SET @CurrentAgeEnd= (Select AgeRangeEnd From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)
--   END				


--   SET @CurrentAgeRangeID = 1
  -- SET @CurrentAgeStart= (Select AgeRangeStart From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)
   --SET @CurrentAgeEnd= (Select AgeRangeEnd From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)	

--      While @CurrentAgeRangeID < @maxAgeRangeID
	--Begin

--SELECT @CurrentAgeRangeID , @CurrentAgeStart, @CurrentAgeEnd

        --Build a TempTable
            --Clean #_Temp_Referral_AgeSelect
               TRUNCATE TABLE #_Temp_Referral_AgeSelect
            --Insert Data into #_Temp_Referral_AgeSelect based on agerange, gender, month and year
		set @strSelectLine = 'INSERT #_Temp_Referral_AgeSelect (CallSourceCodeID, ReferralCallerOrganizationID,ReferralID,'
		set @strSelectLine = @strSelectLine + ' ReferralOrganAppropriateID,ReferralBoneAppropriateID,'
                set @strSelectLine = @strSelectLine + ' ReferralTissueAppropriateID,ReferralSkinAppropriateID,'
                set @strSelectLine = @strSelectLine + ' ReferralValvesAppropriateID,ReferralEyesTransAppropriateID,'
                set @strSelectLine = @strSelectLine + ' ReferralEyesRschAppropriateID,ReferralDonorGender, ReferralApproachTypeId, RegistryStatus)'
		set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralOrganAppropriateID,'
                set @strSelectLine = @strSelectLine + ' ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID,'
                set @strSelectLine = @strSelectLine + ' ReferralValvesAppropriateID, ReferralEyesTransAppropriateID,'
                set @strSelectLine = @strSelectLine + ' ReferralEyesRschAppropriateID, ReferralDonorGender, ReferralApproachTypeId,'
                set @strSelectLine = @strSelectLine + ' CASE _ReferralProdReport.dbo.RegistryStatus.RegistryStatus WHEN 1 THEN 1 WHEN 2 THEN 2 WHEN 4 THEN 4 ELSE 0 END AS RegistryStatus '

		set @strSelectLine = @strSelectLine + ' FROM _ReferralProdReport.dbo.Referral'
		set @strSelectLine = @strSelectLine + '  JOIN _ReferralProdReport.dbo.Call ON _ReferralProdReport.dbo.Call.CallID = _ReferralProdReport.dbo.Referral.CallID'
		set @strSelectLine = @strSelectLine + '  JOIN _ReferralProdReport.dbo.SourceCode ON _ReferralProdReport.dbo.Call.SourceCodeID = _ReferralProdReport.dbo.SourceCode.SourceCodeID'
		set @strSelectLine = @strSelectLine + '  JOIN _ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID'
		set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdReport.dbo.TimeZone ON _ReferralProdReport.dbo.Organization.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID'
		
		set @strSelectLine = @strSelectLine + ' LEFT JOIN _ReferralProdReport.dbo.RegistryStatus ON _ReferralProdReport.dbo.Referral.CallId = _ReferralProdReport.dbo.RegistryStatus.CallId '

		set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
		set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))
		--AND      ReferralDonorGender = @DonorGender
		set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorGender is not null'
		set @strSelectLine2 = @strSelectLine2 + ' AND ((cast(ReferralDonorAge as Int) >= '+ltrim(str(@CurrentAgeStart))
		set @strSelectLine2 = @strSelectLine2 + 	' AND cast(ReferralDonorAge as Int) <= '+ltrim(str(@CurrentAgeEnd))
		set @strSelectLine2 = @strSelectLine2 + 	' AND ReferralDonorAgeUnit = '+char(39)+'Years'+char(39)+')'
		set @strSelectLine2 = @strSelectLine2 + ' OR (cast(ReferralDonorAge as Int) >= '+ltrim(str(@CurrentAgeStart * 365))
		set @strSelectLine2 = @strSelectLine2 + 	' AND cast(ReferralDonorAge as Int) <= '+ltrim(str(@CurrentAgeEnd * 365))
		set @strSelectLine2 = @strSelectLine2 + 	' AND ReferralDonorAgeUnit = '+char(39)+'Days'+char(39)+')'
		set @strSelectLine2 = @strSelectLine2 + ' OR (cast(ReferralDonorAge as Int)>= '+ltrim(str(@CurrentAgeStart * 12))
		set @strSelectLine2 = @strSelectLine2 + 	' AND cast(ReferralDonorAge as Int) <= '+ltrim(str(@CurrentAgeEnd * 12))
		set @strSelectLine2 = @strSelectLine2 + 	' AND ReferralDonorAgeUnit = '+char(39)+'Months'+char(39)+'))'
		set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdReport.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID'

		EXEC(@strSelectLine+@strSelectLine2)




	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_AgeDemo
	    SET      AllTypes = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender,
	             Count(ReferralID) AS ReferralCount
	    FROM     #_Temp_Referral_AgeSelect

           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************
	   UPDATE		#_Temp_Referral_AgeDemo
	   SET		AppropriateOrgan = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
			Count(ReferralID) AS ReferralCount
           FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralOrganAppropriateID = 1
	
	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET		AppropriateBone = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		        Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralBoneAppropriateID = 1
           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET		AppropriateTissue = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
			Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralTissueAppropriateID = 1
	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
		
--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET		AppropriateSkin = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
	         	Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralSkinAppropriateID = 1
	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET	AppropriateValves = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		      Count(ReferralID) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralValvesAppropriateID = 1
	   GROUP BY CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET	AppropriateEyes = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		      Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesTransAppropriateID = 1
	   GROUP BY  CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET	AppropriateOther = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
         	   Count(ReferralID) AS ReferralCount  
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesRschAppropriateID = 1
	   GROUP BY   CallSourceCodeID,    ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID

	   AND	   MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AgeDemo
	   SET	   AppropriateAllTissue = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		   Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralBoneAppropriateID = 1
	   OR	   ReferralTissueAppropriateID = 1
	   OR	   ReferralSkinAppropriateID = 1
	   OR	   ReferralValvesAppropriateID = 1)
	   GROUP BY   CallSourceCodeID,    ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AgeDemo
	   SET	   AppropriateRO = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		   Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralOrganAppropriateID <> 1 
	   AND	   ReferralBoneAppropriateID <> 1
	   AND	   ReferralTissueAppropriateID <> 1
	   AND	   ReferralSkinAppropriateID <> 1
	   AND	   ReferralValvesAppropriateID <> 1
	   AND	   ReferralEyesTransAppropriateID <>1
	   AND	   ReferralEyesRschAppropriateID <>1)
	   GROUP BY   CallSourceCodeID,    ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- All Referrals Count - Registered
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_AgeDemo
	    SET      AllTypes_Reg = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender,
	             Count(ReferralID) AS ReferralCount
	    FROM     #_Temp_Referral_AgeSelect
		WHERE ReferralApproachTypeID = 8
		OR RegistryStatus > 0

          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE		#_Temp_Referral_AgeDemo
	   SET		AppropriateOrgan_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
			Count(ReferralID) AS ReferralCount
           FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralOrganAppropriateID = 1
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)
	
	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET		AppropriateBone_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		        Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralBoneAppropriateID = 1
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET		AppropriateTissue_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
			Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralTissueAppropriateID = 1
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		AgeRangeID = @CurrentAgeRangeID
	   AND 		DonorGender = CountTable.ReferralDonorGender
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
		
--**************************************************************************************************************************************************************************************
	-- AppropriateSkin - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET		AppropriateSkin_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
	         	Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralSkinAppropriateID = 1
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves  - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET	AppropriateValves_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		      Count(ReferralID) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralValvesAppropriateID = 1
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

	   GROUP BY CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes - Registered

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET	AppropriateEyes_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		      Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesTransAppropriateID = 1
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther - Registered

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AgeDemo
	   SET	AppropriateOther_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
         	   Count(ReferralID) AS ReferralCount  
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesRschAppropriateID = 1
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

	   GROUP BY  CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID

	   AND	   MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AgeDemo
	   SET	   AppropriateAllTissue_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		   Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralBoneAppropriateID = 1
	   OR	   ReferralTissueAppropriateID = 1
	   OR	   ReferralSkinAppropriateID = 1
	   OR	   ReferralValvesAppropriateID = 1)
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

	   GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out - Registered
--***************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AgeDemo
	   SET	   AppropriateRO_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID,  ReferralDonorGender,
		   Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralOrganAppropriateID <> 1 
	   AND	   ReferralBoneAppropriateID <> 1
	   AND	   ReferralTissueAppropriateID <> 1
	   AND	   ReferralSkinAppropriateID <> 1
	   AND	   ReferralValvesAppropriateID <> 1
	   AND	   ReferralEyesTransAppropriateID <>1
	   AND	   ReferralEyesRschAppropriateID <>1)
	   AND 		(ReferralApproachTypeID = 8
		OR 		RegistryStatus > 0)

	   GROUP BY   CallSourceCodeID,    ReferralCallerOrganizationID, ReferralDonorGender
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   AgeRangeID = @CurrentAgeRangeID
	   AND 	   DonorGender = CountTable.ReferralDonorGender
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************
--select top 1 agerangeid from Referral_AgeDemoCount WHERE 	AgeRangeID = @CurrentAgeRangeID
--select top 1 YearID from Referral_AgeDemoCount WHERE 	YearID = @YearID
--select top 1 MonthID from Referral_AgeDemoCount WHERE 	MonthID = @MonthID
	-- Delete any records for the given month and year
	DELETE 	Referral_AgeDemoCount
	WHERE 	AgeRangeID = @CurrentAgeRangeID
        AND	   YearID = @YearID
	AND	   MonthID = @MonthID


	----Update the count statistics
	INSERT INTO Referral_AgeDemoCount
	SELECT * FROM #_Temp_Referral_AgeDemo 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID, AgeRangeID
        
	SET @CurrentAgeRangeID = @CurrentAgeRangeID + 1
        SET @CurrentAgeStart= (Select AgeRangeStart From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)
	SET @CurrentAgeEnd= (Select AgeRangeEnd From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)


END
        DROP TABLE #_Temp_Referral_AgeSelect             
	DROP TABLE #_Temp_Referral_AgeDemo

GO



SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

