SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_AverageAgeCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_AverageAgeCount_Archive]
GO





-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_AverageAgeCount_Archive 3, 2000, 'M'

CREATE PROCEDURE spi_Referral_AverageAgeCount_Archive
   @MonthID	int,
   @YearID	int,
   @DonorGender varchar
	

AS

DECLARE
   
   @ReferralCount	int,
   @CurrentAgeRangeID	int,
   @CurrentAgeStart	int,
   @CurrentAgeEnd	int,
   @DayLightStartDate   	datetime,	
   @DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT	 
	
--Create the temp table
CREATE TABLE #_Temp_Referral_AverageAge 
   (
   [YearID] [int] NULL ,
   [MonthID] [int] NULL ,
   [SourceCodeID] [int] NULL ,
   [OrganizationID] [int] NULL ,
   [DonorGender] [char](1) NULL ,
   [AllTypesAge] [int] NULL Default (NULL) ,
   [AppropriateOrganAge] [int] NULL Default (NULL) ,
   [AppropriateBoneAge] [int] NULL Default (NULL)  ,
   [AppropriateTissueAge] [int] NULL Default (NULL) ,
   [AppropriateSkinAge] [int] NULL Default (NULL)  ,
   [AppropriateValvesAge] [int] NULL Default (NULL) ,
   [AppropriateEyesAge] [int] NULL Default (NULL)  ,
   [AppropriateOtherAge] [int] NULL Default (NULL) ,
   [AppropriateAllTissueAge] [int] NULL Default (NULL)  ,
   [AppropriateROAge] [int] NULL Default (NULL) ,

   --2/8/02 drh
   [AllTypesAge_Reg] [int] NULL Default (NULL) ,
   [AppropriateOrganAge_Reg] [int] NULL Default (NULL) ,
   [AppropriateBoneAge_Reg] [int] NULL Default (NULL)  ,
   [AppropriateTissueAge_Reg] [int] NULL Default (NULL) ,
   [AppropriateSkinAge_Reg] [int] NULL Default (NULL)  ,
   [AppropriateValvesAge_Reg] [int] NULL Default (NULL) ,
   [AppropriateEyesAge_Reg] [int] NULL Default (NULL)  ,
   [AppropriateOtherAge_Reg] [int] NULL Default (NULL) ,
   [AppropriateAllTissueAge_Reg] [int] NULL Default (NULL)  ,
   [AppropriateROAge_Reg] [int] NULL Default (NULL)
   )

CREATE TABLE #_Temp_Referral_AgeSelect
   (
   [CallSourceCodeID] [int] NULL ,
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralDonorAge] [varchar] (4) NULL ,
   [ReferralOrganAppropriateID][int] NULL,
   [ReferralBoneAppropriateID][int] NULL,
   [ReferralTissueAppropriateID][int] NULL,
   [ReferralSkinAppropriateID][int] NULL,
   [ReferralValvesAppropriateID][int] NULL,
   [ReferralEyesTransAppropriateID][int] NULL,
   [ReferralEyesRschAppropriateID][int] NULL,

   --2/8/02 drh
   [ReferralApproachTypeID][int] NULL
   )
	
--Clean temp table
TRUNCATE TABLE  #_Temp_Referral_AverageAge

--Store TimeZone CASE string
exec spf_tzCase 'TimeZoneAbbreviation','CallDateTime', @DayLightStartDate, @DayLightEndDate, @strTemp OUTPUT

--SET @CurrentAgeRangeID = 1
--SET @CurrentAgeStart= (Select AgeRangeStart From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)
--SET @CurrentAgeEnd= (Select AgeRangeEnd From AgeRange WHERE AgeRangeID = @CurrentAgeRangeID)

--While @CurrentAgeRangeID < 12
--   Begin

	set @strSelectLine = 'INSERT #_Temp_Referral_AverageAge'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID,  DonorGender)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, '+@strTemp+', CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' _ReferralProdArchive.dbo.Call.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID ,	ReferralDonorGender'--, AgeRangeID

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Call'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorGender = '+char(39)+@DonorGender+char(39)
	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorGender is not null'
	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorAgeUnit = '+char(39)+'Years'+char(39)

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)

        --Build a TempTable
            --Clean #_Temp_Referral_AgeSelect
               TRUNCATE TABLE  #_Temp_Referral_AgeSelect
            --Insert Data into #_Temp_Referral_AgeSelect based on agerange, gender, month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_AgeSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralDonorAge, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID, ReferralApproachTypeId)'

	set @strSelectLine = @strSelectLine + ' SELECT _ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralDonorAge, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID, ReferralApproachTypeId'

	set @strSelectLine = @strSelectLine + '	FROM _ReferralProdArchive.dbo.Referral'
	set @strSelectLine = @strSelectLine + ' JOIN _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID'
	-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, '+@strTemp+', CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, '+ @strTemp + ', CallDateTime)) = ' + ltrim(str(@MonthID))

	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorGender = '+char(39)+@DonorGender+char(39)
	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorGender is not null'
	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorAgeUnit = '+char(39)+'Years'+char(39)

	EXEC(@strSelectLine+@strSelectLine2)


	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_AverageAge
	    SET      AllTypesAge = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   CallSourceCodeID, ReferralCallerOrganizationID, 
	             Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	    FROM     #_Temp_Referral_AgeSelect
          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************
	   UPDATE		#_Temp_Referral_AverageAge
	   SET		AppropriateOrganAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
      	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
           FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralOrganAppropriateID = 1
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge

	   SET		AppropriateBoneAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralBoneAppropriateID = 1
           GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET		AppropriateTissueAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
   	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralTissueAppropriateID = 1
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET		AppropriateSkinAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
   	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralSkinAppropriateID = 1
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET	AppropriateValvesAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID, 
   	              Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralValvesAppropriateID = 1
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET	AppropriateEyesAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID, 
   	              Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesTransAppropriateID = 1
	   GROUP 
           BY      CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET	AppropriateOtherAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID, 
   	           Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesRschAppropriateID = 1
	   GROUP 
           BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AverageAge
	   SET	   AppropriateAllTissueAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID, 
   	           Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralBoneAppropriateID = 1
	   OR	   ReferralTissueAppropriateID = 1
	   OR	   ReferralSkinAppropriateID = 1
	   OR	   ReferralValvesAppropriateID = 1)
	   GROUP 
           BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AverageAge
	   SET	   AppropriateROAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID, 
   	            Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralOrganAppropriateID <> 1 
	   AND	   ReferralBoneAppropriateID <> 1
	   AND	   ReferralTissueAppropriateID <> 1
	   AND	   ReferralSkinAppropriateID <> 1
	   AND	   ReferralValvesAppropriateID <> 1
	   AND	   ReferralEyesTransAppropriateID <>1
	   AND	   ReferralEyesRschAppropriateID <>1)
	   GROUP 
           BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- All Referrals Count - Registered
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_AverageAge
	    SET      AllTypesAge_Reg = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   CallSourceCodeID, ReferralCallerOrganizationID, 
	             Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	    FROM     #_Temp_Referral_AgeSelect
		WHERE ReferralApproachTypeID = 8
          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE		#_Temp_Referral_AverageAge
	   SET		AppropriateOrganAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
      	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
           FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralOrganAppropriateID = 1
	   AND ReferralApproachTypeID = 8
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge

	   SET		AppropriateBoneAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralBoneAppropriateID = 1
	   AND ReferralApproachTypeID = 8
           GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET		AppropriateTissueAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
   	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM		#_Temp_Referral_AgeSelect
	   WHERE	ReferralTissueAppropriateID = 1
	   AND ReferralApproachTypeID = 8
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateSkin - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET		AppropriateSkinAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
   	                Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralSkinAppropriateID = 1
	   AND ReferralApproachTypeID = 8
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves  - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET	AppropriateValvesAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID, 
   	              Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralValvesAppropriateID = 1
	   AND ReferralApproachTypeID = 8
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes - Registered

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET	AppropriateEyesAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID, 
   	              Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesTransAppropriateID = 1
	   AND ReferralApproachTypeID = 8
	   GROUP 
           BY      CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther - Registered

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_AverageAge
	   SET	AppropriateOtherAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID, 
   	           Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   ReferralEyesRschAppropriateID = 1
	   AND ReferralApproachTypeID = 8
	   GROUP 
           BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AverageAge
	   SET	   AppropriateAllTissueAge_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID, 
   	           Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralBoneAppropriateID = 1
	   OR	   ReferralTissueAppropriateID = 1
	   OR	   ReferralSkinAppropriateID = 1
	   OR	   ReferralValvesAppropriateID = 1)
	   AND ReferralApproachTypeID = 8

	   GROUP 
           BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out - Registered
--***************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_AverageAge
	   SET	   AppropriateROAge = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID, 
   	            Avg(CAST(ReferralDonorAge AS int)) AS ReferralCount
	   FROM	   #_Temp_Referral_AgeSelect
	   WHERE   (ReferralOrganAppropriateID <> 1 
	   AND	   ReferralBoneAppropriateID <> 1
	   AND	   ReferralTissueAppropriateID <> 1
	   AND	   ReferralSkinAppropriateID <> 1
	   AND	   ReferralValvesAppropriateID <> 1
	   AND	   ReferralEyesTransAppropriateID <>1
	   AND	   ReferralEyesRschAppropriateID <>1)
	   AND ReferralApproachTypeID = 8
	   GROUP 
           BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_AverageAgeCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID
        AND     DonorGender = @DonorGender


	--Update the count statistics
	INSERT INTO Referral_AverageAgeCount
	SELECT * FROM #_Temp_Referral_AverageAge 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID

--Select * from #_Temp_Referral_AverageAge

      DROP TABLE #_Temp_Referral_AverageAge
      DROP TABLE #_Temp_Referral_AgeSelect














GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

