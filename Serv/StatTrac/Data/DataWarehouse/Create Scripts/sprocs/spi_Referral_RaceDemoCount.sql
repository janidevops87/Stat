SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_RaceDemoCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_RaceDemoCount]
GO





-- Updated w/tzCASE function 04.0700 [ttw]

-- SP_HELP 
-- spi_Referral_RaceDemoCount 12, 1999

CREATE PROCEDURE spi_Referral_RaceDemoCount
   @MonthID	int,
   @YearID	int
AS

DECLARE
	@DayLightStartDate   	datetime,
	@DayLightEndDate     	datetime,

	@strSelectLine		varchar(8000),
	@strSelectLine2		varchar(8000),
	@strTemp		varchar(2000)
	

     	
--Create the temp table
CREATE TABLE #_Temp_Referral_RaceDemo 
   (
   [YearID] [int] NULL ,
   [MonthID] [int] NULL ,
   [SourceCodeID] [int] NULL ,
   [OrganizationID] [int] NULL ,
   [DonorGender] [char](1) NULL ,
   [RaceID] [int] NULL ,	
   [AllTypes] [int] NULL Default (0) ,
   [AppropriateOrgan] [int] NULL Default (0),
   [AppropriateBone] [int] NULL  Default (0),
   [AppropriateTissue] [int] NULL Default (0),
   [AppropriateSkin] [int] NULL  Default (0),
   [AppropriateValves] [int] NULL Default (0),
   [AppropriateEyes] [int] NULL  Default (0),
   [AppropriateOther] [int] NULL Default (0),
   [AppropriateAllTissue] [int] NULL  Default (0),
   [AppropriateRO] [int] NULL Default (0),

   --drh 2/15/02
   [AllTypes_Reg] [int] NULL Default (0) ,
   [AppropriateOrgan_Reg] [int] NULL Default (0),
   [AppropriateBone_Reg] [int] NULL  Default (0),
   [AppropriateTissue_Reg] [int] NULL Default (0),
   [AppropriateSkin_Reg] [int] NULL  Default (0),
   [AppropriateValves_Reg] [int] NULL Default (0),
   [AppropriateEyes_Reg] [int] NULL  Default (0),
   [AppropriateOther_Reg] [int] NULL Default (0),
   [AppropriateAllTissue_Reg] [int] NULL  Default (0),
   [AppropriateRO_Reg] [int] NULL Default (0) 
   )

CREATE TABLE #_Temp_Referral_RaceSelect
   (
   [CallSourceCodeID] [int] NULL ,
   [ReferralCallerOrganizationID][int] NULL, 
   [ReferralID][int] NULL, 
   [ReferralDonorRaceID][int] NULL, 
   [ReferralDonorGender][char](1) NULL,
   [ReferralOrganAppropriateID][int] NULL,
   [ReferralBoneAppropriateID][int] NULL,
   [ReferralTissueAppropriateID][int] NULL,
   [ReferralSkinAppropriateID][int] NULL,
   [ReferralValvesAppropriateID][int] NULL,
   [ReferralEyesTransAppropriateID][int] NULL,
   [ReferralEyesRschAppropriateID][int] NULL,

   --drh 2/15/02
   [ReferralApproachTypeID][int] NULL
   )
	
--Clean temp table
TRUNCATE TABLE   #_Temp_Referral_RaceDemo




	set @strSelectLine = 'INSERT #_Temp_Referral_RaceDemo'
	set @strSelectLine = @strSelectLine + ' (YearID, MonthID, SourceCodeID, OrganizationID,  DonorGender, RaceID)'

	set @strSelectLine = @strSelectLine + ' SELECT DISTINCT DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) AS YearID,'
	set @strSelectLine = @strSelectLine + ' DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) AS MonthID,'
	set @strSelectLine = @strSelectLine + ' vwDataWarehouseCall.SourceCodeID,'	
	set @strSelectLine = @strSelectLine + ' ReferralCallerOrganizationID ,	ReferralDonorGender, ReferralDonorRaceID'

	set @strSelectLine = @strSelectLine + '	FROM vwDataWarehouseCall'
	set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseReferral ON vwDataWarehouseReferral.CallID = vwDataWarehouseCall.CallID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseSourceCode ON vwDataWarehouseCall.SourceCodeID = vwDataWarehouseSourceCode.SourceCodeID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID'
	set @strSelectLine = @strSelectLine + '	JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID'
				-- ccarroll 08/01/2011 Added Join to TimeZone  

	set @strSelectLine2 = '	WHERE DATEPART(yyyy, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = '+ltrim(str(@YearID))
	set @strSelectLine2 = @strSelectLine2 + ' AND DATEPART(m, DATEADD(hour, dbo.fn_TimeZoneDifference(TimeZoneAbbreviation , CallDateTime), CallDateTime)) = ' + ltrim(str(@MonthID))
	set @strSelectLine2 = @strSelectLine2 + ' AND ReferralDonorGender is not null'

	set @strSelectLine2 = @strSelectLine2 + ' ORDER BY vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID'

	EXEC(@strSelectLine+@strSelectLine2)

--Build a TempTable
            --Clean #_Temp_Referral_?Select
               TRUNCATE TABLE   #_Temp_Referral_RaceSelect
        --Insert Data into #_Temp_Referral_?Select based on month and year
	set @strSelectLine = 'INSERT #_Temp_Referral_RaceSelect'
	set @strSelectLine = @strSelectLine + ' (CallSourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralDonorRaceID, ReferralDonorGender, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID, ReferralApproachTypeId)'

	set @strSelectLine = @strSelectLine + ' SELECT vwDataWarehouseCall.SourceCodeID, ReferralCallerOrganizationID, ReferralID, ReferralDonorRaceID, ReferralDonorGender, ReferralOrganAppropriateID, ReferralBoneAppropriateID, ReferralTissueAppropriateID, ReferralSkinAppropriateID, ReferralValvesAppropriateID, ReferralEyesTransAppropriateID, ReferralEyesRschAppropriateID, ReferralApproachTypeId'

	set @strSelectLine = @strSelectLine + '	FROM vwDataWarehouseReferral'
	set @strSelectLine = @strSelectLine + ' JOIN vwDataWarehouseCall ON vwDataWarehouseCall.CallID = vwDataWarehouseReferral.CallID'
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
            UPDATE   #_Temp_Referral_RaceDemo
	    SET      AllTypes = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   CallSourceCodeID, ReferralCallerOrganizationID,
                     ReferralDonorRaceID, 
                     ReferralDonorGender,
	             Count(ReferralID) AS ReferralCount
	    FROM     #_Temp_Referral_RaceSelect
          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateOrgan = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
           FROM		#_Temp_Referral_RaceSelect
	   WHERE	ReferralOrganAppropriateID = 1
          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateBone = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_RaceSelect
	   WHERE	ReferralBoneAppropriateID = 1
          GROUP BY      CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateTissue = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_RaceSelect
	   WHERE	ReferralTissueAppropriateID = 1
           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
		
--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateSkin = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM	        #_Temp_Referral_RaceSelect
	   WHERE        ReferralSkinAppropriateID = 1
           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET	        AppropriateValves = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,
                      ReferralDonorRaceID, 
                      ReferralDonorGender,
	              Count(ReferralID) AS ReferralCount
	   FROM	      #_Temp_Referral_RaceSelect
	   WHERE      ReferralValvesAppropriateID = 1
           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET	        AppropriateEyes = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT       CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM	        #_Temp_Referral_RaceSelect
	   WHERE        ReferralEyesTransAppropriateID = 1
          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET	        AppropriateOther = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT       CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM	        #_Temp_Referral_RaceSelect
	   WHERE        ReferralEyesRschAppropriateID = 1
           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_RaceDemo
	   SET	   AppropriateAllTissue = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,
                      ReferralDonorRaceID, 
                      ReferralDonorGender,
	              Count(ReferralID) AS ReferralCount
	   FROM	      #_Temp_Referral_RaceSelect
	   WHERE      (ReferralBoneAppropriateID = 1
         	   OR	   ReferralTissueAppropriateID = 1
	           OR	   ReferralSkinAppropriateID = 1
	           OR	   ReferralValvesAppropriateID = 1)
          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_RaceDemo
	   SET	   AppropriateRO = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT      CallSourceCodeID, ReferralCallerOrganizationID,
                       ReferralDonorRaceID, 
                       ReferralDonorGender,
	               Count(ReferralID) AS ReferralCount
	   FROM	       #_Temp_Referral_RaceSelect  
	   WHERE       (ReferralOrganAppropriateID <> 1 
         	   AND	   ReferralBoneAppropriateID <> 1
	           AND	   ReferralTissueAppropriateID <> 1
	           AND	   ReferralSkinAppropriateID <> 1
	           AND	   ReferralValvesAppropriateID <> 1
	           AND	   ReferralEyesTransAppropriateID <>1
	           AND	   ReferralEyesRschAppropriateID <>1)
          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender

--**************************************************************************************************************************************************************************************
	-- All Referrals Count - Registered
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_RaceDemo
	    SET      AllTypes_Reg = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   CallSourceCodeID, ReferralCallerOrganizationID,
                     ReferralDonorRaceID, 
                     ReferralDonorGender,
	             Count(ReferralID) AS ReferralCount
	    FROM     #_Temp_Referral_RaceSelect
		WHERE ReferralApproachTypeID = 8

          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender

--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateOrgan_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
           FROM		#_Temp_Referral_RaceSelect
	   WHERE	ReferralOrganAppropriateID = 1
	   AND 		ReferralApproachTypeID = 8

          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateBone - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateBone_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_RaceSelect
	   WHERE	ReferralBoneAppropriateID = 1
	   AND 		ReferralApproachTypeID = 8

          GROUP BY      CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateTissue - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateTissue_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_RaceSelect
	   WHERE	ReferralTissueAppropriateID = 1
	   AND 		ReferralApproachTypeID = 8

           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
		
--**************************************************************************************************************************************************************************************
	-- AppropriateSkin - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET		AppropriateSkin_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM	        #_Temp_Referral_RaceSelect
	   WHERE        ReferralSkinAppropriateID = 1
	   AND 		ReferralApproachTypeID = 8

           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateValves  - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET	        AppropriateValves_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,
                      ReferralDonorRaceID, 
                      ReferralDonorGender,
	              Count(ReferralID) AS ReferralCount
	   FROM	      #_Temp_Referral_RaceSelect
	   WHERE      ReferralValvesAppropriateID = 1
	   AND 		ReferralApproachTypeID = 8

           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateEyes - Registered


--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET	        AppropriateEyes_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT       CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM	        #_Temp_Referral_RaceSelect
	   WHERE        ReferralEyesTransAppropriateID = 1
	   AND 		ReferralApproachTypeID = 8

          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--**************************************************************************************************************************************************************************************
	-- AppropriateOther - Registered

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_RaceDemo
	   SET	        AppropriateOther_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT       CallSourceCodeID, ReferralCallerOrganizationID,
                        ReferralDonorRaceID, 
                        ReferralDonorGender,
	                Count(ReferralID) AS ReferralCount
	   FROM	        #_Temp_Referral_RaceSelect
	   WHERE        ReferralEyesRschAppropriateID = 1
	   AND 		ReferralApproachTypeID = 8

           GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender

--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue - Registered
--**************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_RaceDemo
	   SET	   AppropriateAllTissue_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID,
                      ReferralDonorRaceID, 
                      ReferralDonorGender,
	              Count(ReferralID) AS ReferralCount
	   FROM	      #_Temp_Referral_RaceSelect
	   WHERE      (ReferralBoneAppropriateID = 1
         	   OR	   ReferralTissueAppropriateID = 1
	           OR	   ReferralSkinAppropriateID = 1
	           OR	   ReferralValvesAppropriateID = 1)
	   AND 		ReferralApproachTypeID = 8

          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender
--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out - Registered
--***************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_RaceDemo
	   SET	   AppropriateRO_Reg = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT      CallSourceCodeID, ReferralCallerOrganizationID,
                       ReferralDonorRaceID, 
                       ReferralDonorGender,
	               Count(ReferralID) AS ReferralCount
	   FROM	       #_Temp_Referral_RaceSelect  
	   WHERE       (ReferralOrganAppropriateID <> 1 
         	   AND	   ReferralBoneAppropriateID <> 1
	           AND	   ReferralTissueAppropriateID <> 1
	           AND	   ReferralSkinAppropriateID <> 1
	           AND	   ReferralValvesAppropriateID <> 1
	           AND	   ReferralEyesTransAppropriateID <>1
	           AND	   ReferralEyesRschAppropriateID <>1)
	   AND 		ReferralApproachTypeID = 8

          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID, ReferralDonorRaceID, ReferralDonorGender
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
           AND		RaceID = CountTable.ReferralDonorRaceID
	   AND 		DonorGender = CountTable.ReferralDonorGender

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************

	-- Delete any records for the given month and year
	DELETE 	Referral_RaceDemoCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID
        
	--Update the count statistics
	INSERT INTO Referral_RaceDemoCount
	SELECT * FROM #_Temp_Referral_RaceDemo 
	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID

--Select * from #_Temp_Referral_RaceDemo
      DROP TABLE #_Temp_Referral_RaceDemo
      DROP TABLE #_Temp_Referral_RaceSelect















GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

