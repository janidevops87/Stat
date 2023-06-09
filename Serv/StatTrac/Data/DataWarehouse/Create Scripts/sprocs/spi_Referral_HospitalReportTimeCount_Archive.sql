SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Referral_HospitalReportTimeCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spi_Referral_HospitalReportTimeCount_Archive]
GO




-- SP_HELP 
-- spi_Referral_HospitalReportTimeCount_Archive 3, 2000
CREATE PROCEDURE spi_Referral_HospitalReportTimeCount_Archive
   @MonthID	int,
   @YearID	int

AS

DECLARE
   
	@ReferralCount		int,
   	@CurrentHospitalReportTimeRangeID	int,
   	@CurrentTimeStart	int,
   	@CurrentTimeEnd		int,
   	@MaxTimeRangeID      	int,
	@DayLightStartDate   	datetime,
	@DayLightEndDate     	datetime
	

     Exec spf_GetDayLightDates @YearID, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
	
--Create the temp table
CREATE TABLE #_Temp_Referral_HospitalReport 
   (
   [YearID] [int] NULL ,
   [MonthID] [int] NULL ,
   [SourceCodeID] [int] NULL ,
   [OrganizationID] [int] NULL ,
   [HospitalReportTimeRangeID] [int] NULL ,	
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

CREATE TABLE #_Temp_Referral_TimeRangeSelect
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
   [ReferralEyesRschAppropriateID][int] NULL
   )

--Build #ReportTimeCalcTable
CREATE TABLE #ReportTimeCalcTable
     (
     [ReportTimeCalcTableID][int]NULL,
     [DeathHour][int]NULL,
     [DeathMinute][int]NULL
     )

     INSERT #ReportTimeCalcTable
     (ReportTimeCalcTableID, DeathHour, DeathMinute)
         SELECT  ReferralID, 
                 convert(int, substring( ReferralDonorDeathTime, 1, 2 )) ,
                 convert(int,substring( ReferralDonorDeathTime, 4, 2 ))

         FROM     _ReferralProdArchive..Referral
         JOIN     _ReferralProdArchive..Call ON _ReferralProdArchive..Call.CallID = _ReferralProdArchive..Referral.CallID         
         JOIN     _ReferralProdArchive..Organization ON _ReferralProdArchive..Organization.OrganizationID = _ReferralProdArchive..Referral.ReferralCallerOrganizationID               
 		 JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID
				-- ccarroll 07/29/2011 Added Join to TimeZone  

         WHERE    DATEPART(yyyy, DATEADD(hour, (CASE 
							When TimeZoneAbbreviation =  'AT' Then 3        
        	                                 				When TimeZoneAbbreviation =  'ET' Then 2          
							When TimeZoneAbbreviation =  'CT' Then 1          
							When TimeZoneAbbreviation =  'MT' Then 0
							When TimeZoneAbbreviation =  'PT' Then -1          
							When TimeZoneAbbreviation =  'KT' Then -2           
							When TimeZoneAbbreviation =  'HT' Then -3           
							When TimeZoneAbbreviation =  'ST' Then -4

							When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
							When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
							When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                        	                 				When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                	         				When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
							When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
							When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
							When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
						END ), CallDateTime)) = @YearID
         AND      DATEPART(m, DATEADD(hour, (CASE 
						When TimeZoneAbbreviation =  'AT' Then 3        
       	                                 	When TimeZoneAbbreviation =  'ET' Then 2          
               	                         	When TimeZoneAbbreviation =  'CT' Then 1          
                       	                 	When TimeZoneAbbreviation =  'MT' Then 0
                                         	When TimeZoneAbbreviation =  'PT' Then -1          
                               	         	When TimeZoneAbbreviation =  'KT' Then -2           
       	                                 	When TimeZoneAbbreviation =  'HT' Then -3           
                                       	 	When TimeZoneAbbreviation =  'ST' Then -4

                                         	When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
       	                                 	When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
               	                         	When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                       	                 	When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                               	         	When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                       	 	When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                       		When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
                                         	When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
					     END ), CallDateTime)) = @MonthID
         AND      ReferralDonorDeathDate IS NOT NULL
         AND      LEN(ReferralDonorDeathTime)= 8
         AND      SUBSTRING(ReferralDonorDeathTime,3,1) = ':' 
         



	
--Clean temp table
TRUNCATE TABLE   #_Temp_Referral_HospitalReport

SET @CurrentHospitalReportTimeRangeID = 1
SET @CurrentTimeStart = (Select TimeRangeStart From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)
SET @CurrentTimeEnd = (Select TimeRangeEnd From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)
SET @MaxTimeRangeID = (SELECT MAX(HospitalReportTimeRangeID) FROM HospitalReportTimeRange )

While @CurrentHospitalReportTimeRangeID <= @MaxTimeRangeID
   Begin
      --Get the list of organizations
      INSERT #_Temp_Referral_HospitalReport
      (YearID, MonthID, SourceCodeID, OrganizationID,  HospitalReportTimeRangeID)
      SELECT DISTINCT
         DATEPART(yyyy, DATEADD(hour, (CASE 
				When TimeZoneAbbreviation =  'AT' Then 3        
    	                                 	When TimeZoneAbbreviation =  'ET' Then 2          
               	                         	When TimeZoneAbbreviation =  'CT' Then 1          
                       	                 	When TimeZoneAbbreviation =  'MT' Then 0
                                         	When TimeZoneAbbreviation =  'PT' Then -1          
                               	         	When TimeZoneAbbreviation =  'KT' Then -2           
       	                                 	When TimeZoneAbbreviation =  'HT' Then -3           
                                       	 	When TimeZoneAbbreviation =  'ST' Then -4

                                         	When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
       	                                 	When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
               	                         	When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                       	                 	When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                               	         	When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                       	 	When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                       		When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
                                         	When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
					END ), CallDateTime)) AS YearID,
         DATEPART(m, DATEADD(hour, (CASE 
					When TimeZoneAbbreviation =  'AT' Then 3        
        	                        When TimeZoneAbbreviation =  'ET' Then 2          
                	                When TimeZoneAbbreviation =  'CT' Then 1          
                        	        When TimeZoneAbbreviation =  'MT' Then 0
	                                When TimeZoneAbbreviation =  'PT' Then -1          
                                	When TimeZoneAbbreviation =  'KT' Then -2           
        	                        When TimeZoneAbbreviation =  'HT' Then -3           
                                        When TimeZoneAbbreviation =  'ST' Then -4

	                                When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
        	                        When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                	                When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                        	        When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                	When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                        When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                        When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
	                                When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
				     END ), CallDateTime)) AS MonthID,
	_ReferralProdArchive.dbo.Call.SourceCodeID,
	ReferralCallerOrganizationID ,	
	HospitalReportTimeRangeID

         FROM	_ReferralProdArchive.dbo.Call
         JOIN	_ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID
	 JOIN   _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID
         JOIN	_ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID	
		 JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID
				-- ccarroll 07/29/2011 Added Join to TimeZone  
         JOIN   _ReferralProd_DataWarehouse.dbo.HospitalReportTimeRange ON _ReferralProd_DataWarehouse.dbo.HospitalReportTimeRange.HospitalReportTimeRangeID = _ReferralProd_DataWarehouse.dbo.HospitalReportTimeRange.HospitalReportTimeRangeID
         JOIN   #ReportTimeCalcTable ON #ReportTimeCalcTable.ReportTimeCalcTableID = _ReferralProdArchive.dbo.Referral.ReferralID

         WHERE   DATEPART(yyyy, DATEADD(hour, (CASE 
						When TimeZoneAbbreviation =  'AT' Then 3        
                                         	When TimeZoneAbbreviation =  'ET' Then 2          
                                         	When TimeZoneAbbreviation =  'CT' Then 1          
                                         	When TimeZoneAbbreviation =  'MT' Then 0
                                         	When TimeZoneAbbreviation =  'PT' Then -1          
                                         	When TimeZoneAbbreviation =  'KT' Then -2           
                                         	When TimeZoneAbbreviation =  'HT' Then -3           
                                         	When TimeZoneAbbreviation =  'ST' Then -4

                                         	When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
                                         	When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                                         	When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                                         	When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                         	When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                         	When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                         	When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
                                         	When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
					       END ), CallDateTime)) = @YearID
         AND   DATEPART(m, DATEADD(hour, (CASE 
						When TimeZoneAbbreviation =  'AT' Then 3        
                                         	When TimeZoneAbbreviation =  'ET' Then 2          
                                         	When TimeZoneAbbreviation =  'CT' Then 1          
                                         	When TimeZoneAbbreviation =  'MT' Then 0
                                         	When TimeZoneAbbreviation =  'PT' Then -1          
                                         	When TimeZoneAbbreviation =  'KT' Then -2           
                                         	When TimeZoneAbbreviation =  'HT' Then -3           
                                         	When TimeZoneAbbreviation =  'ST' Then -4

                                         	When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
                                         	When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                                         	When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                                         	When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                         	When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                         	When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                         	When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
                                         	When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
					  END ), CallDateTime)) = @MonthID

	 AND   HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID

	 AND   DateDiff( minute, 
			DATEADD(hour, DeathHour,  DATEADD(minute, DeathMinute, ReferralDonorDeathDate)),

			DATEADD(	hour, 
				     	(CASE 
						When TimeZoneAbbreviation =  'AT' Then 3        
                                         			When TimeZoneAbbreviation =  'ET' Then 2          
                                         			When TimeZoneAbbreviation =  'CT' Then 1          
                                         			When TimeZoneAbbreviation =  'MT' Then 0
                                         			When TimeZoneAbbreviation =  'PT' Then -1          
                                         			When TimeZoneAbbreviation =  'KT' Then -2           
                                         			When TimeZoneAbbreviation =  'HT' Then -3           
                                         			When TimeZoneAbbreviation =  'ST' Then -4

                                         			When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
                                         			When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                                         			When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                                         			When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                         			When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                         			When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                         			When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
                                         			When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
					  END ), 
			CallDateTime)
			)  BETWEEN 	 @CurrentTimeStart 
	 		   AND		@CurrentTimeEnd 
			

	/* AND   DateDiff( hour, DateAdd( hour, (CASE 
					When TimeZoneAbbreviation =  'AT' Then 3        
		                                        When TimeZoneAbbreviation =  'ET' Then 2          
        		                                 	When TimeZoneAbbreviation =  'CT' Then 1          
                		                         	When TimeZoneAbbreviation =  'MT' Then 0
                        		                 	When TimeZoneAbbreviation =  'PT' Then -1          
                                		         	When TimeZoneAbbreviation =  'KT' Then -2           
                                        		When TimeZoneAbbreviation =  'HT' Then -3           
                                         		When TimeZoneAbbreviation =  'ST' Then -4
	
	                                         	When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
        		                                 	When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                		                         	When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                        		                 	When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                		         	When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                        		When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
	                                         	When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
        	                                	 	When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
							  END ), DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), 

CallDateTime ) */
                                                        	

         ORDER BY	_ReferralProdArchive.dbo.Call.SourceCodeID, ReferralCallerOrganizationID , HospitalReportTimeRangeID

      SET @CurrentHospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID + 1
      SET @CurrentTimeStart= (Select TimeRangeStart From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)
      SET @CurrentTimeEnd= (Select TimeRangeEnd From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)
   END				


   SET @CurrentHospitalReportTimeRangeID = 1
   SET @CurrentTimeStart= (Select TimeRangeStart From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)
   SET @CurrentTimeEnd= (Select TimeRangeEnd From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)	

      While @CurrentHospitalReportTimeRangeID <= @MaxTimeRangeID
	Begin
        --Build a TempTable
            --Clean #_Temp_Referral_TimeRangeSelect
               TRUNCATE TABLE   #_Temp_Referral_TimeRangeSelect
            --Insert Data into #_Temp_Referral_TimeRangeSelect based on agerange, gender, month and year
               INSERT #_Temp_Referral_TimeRangeSelect
                  (
		     CallSourceCodeID,
                     ReferralCallerOrganizationID, 
	             ReferralID, 
                     ReferralOrganAppropriateID,
                     ReferralBoneAppropriateID,
                     ReferralTissueAppropriateID,
                     ReferralSkinAppropriateID,
                     ReferralValvesAppropriateID,
                     ReferralEyesTransAppropriateID,
                     ReferralEyesRschAppropriateID 
                  )
               SELECT
                     _ReferralProdArchive.dbo.Call.SourceCodeID, 
		     ReferralCallerOrganizationID, 
	             ReferralID, 
                     ReferralOrganAppropriateID,
                     ReferralBoneAppropriateID,
                     ReferralTissueAppropriateID,
                     ReferralSkinAppropriateID,
                     ReferralValvesAppropriateID,
                     ReferralEyesTransAppropriateID,
                     ReferralEyesRschAppropriateID

	             FROM     _ReferralProdArchive.dbo.Referral
                     JOIN     _ReferralProdArchive.dbo.Call ON _ReferralProdArchive.dbo.Call.CallID = _ReferralProdArchive.dbo.Referral.CallID
		     JOIN     _ReferralProdArchive.dbo.SourceCode ON _ReferralProdArchive.dbo.Call.SourceCodeID = _ReferralProdArchive.dbo.SourceCode.SourceCodeID
	             JOIN     _ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID
				 JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID

                     JOIN     #ReportTimeCalcTable ON #ReportTimeCalcTable.ReportTimeCalcTableID = _ReferralProdArchive.dbo.Referral.ReferralID
                     WHERE    DATEPART(yyyy, DATEADD(hour, (CASE 
								When TimeZoneAbbreviation =  'AT' Then 3        
		                                         	When TimeZoneAbbreviation =  'ET' Then 2          
        		                                 	When TimeZoneAbbreviation =  'CT' Then 1          
                		                         	When TimeZoneAbbreviation =  'MT' Then 0
                        		                 	When TimeZoneAbbreviation =  'PT' Then -1          
                                		         	When TimeZoneAbbreviation =  'KT' Then -2           
                                        		 	When TimeZoneAbbreviation =  'HT' Then -3           
                                         			When TimeZoneAbbreviation =  'ST' Then -4

		                                         	When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
        		                                 	When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                		                         	When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                        		                 	When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                	         		When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                		         	When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                        		 	When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
	                                         		When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
							     END ), CallDateTime)) = @YearID
                     AND      DATEPART(m, DATEADD(hour, (CASE 
								When TimeZoneAbbreviation =  'AT' Then 3        
		                                         	When TimeZoneAbbreviation =  'ET' Then 2          
        		                                 	When TimeZoneAbbreviation =  'CT' Then 1          
                		                         	When TimeZoneAbbreviation =  'MT' Then 0
                        		                 	When TimeZoneAbbreviation =  'PT' Then -1          
                                		         	When TimeZoneAbbreviation =  'KT' Then -2           
                                        		 	When TimeZoneAbbreviation =  'HT' Then -3           
                                         			When TimeZoneAbbreviation =  'ST' Then -4
	
	                                         		When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
        		                                 	When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                		                         	When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                        		                 	When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                		         	When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                        		 	When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
	                                         		When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
        	                                	 	When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
							  END ), CallDateTime)) = @MonthID
	 AND   DateDiff( minute, 
			DATEADD(hour, DeathHour,  DATEADD(minute, DeathMinute, ReferralDonorDeathDate)), 
			DATEADD(	hour, 
				     	(CASE 
						When TimeZoneAbbreviation =  'AT' Then 3        
                                         			When TimeZoneAbbreviation =  'ET' Then 2          
                                         			When TimeZoneAbbreviation =  'CT' Then 1          
                                         			When TimeZoneAbbreviation =  'MT' Then 0
                                         			When TimeZoneAbbreviation =  'PT' Then -1          
                                         			When TimeZoneAbbreviation =  'KT' Then -2           
                                         			When TimeZoneAbbreviation =  'HT' Then -3           
                                         			When TimeZoneAbbreviation =  'ST' Then -4

                                         			When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 3 End) 
                                         			When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 2 End) 
                                         			When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else 1 End) 
                                         			When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else 0 End) 
                                         			When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -1 End) 
                                         			When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -3 Else -2 End) 
                                         			When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -4 Else -3 End) 
                                         			When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -5 Else -4 End)
					  END ), 
			CallDateTime)
			) BETWEEN @CurrentTimeStart  AND @CurrentTimeEnd   

/*	             AND      DateDiff( hour, DateAdd( hour, (CASE 
						When TimeZoneAbbreviation =  'AT' Then -3        
		                                         	When TimeZoneAbbreviation =  'ET' Then -2          
        		                                 		When TimeZoneAbbreviation =  'CT' Then -1          
                		                         		When TimeZoneAbbreviation =  'MT' Then 0
                        		                 		When TimeZoneAbbreviation =  'PT' Then 1          
                                		         		When TimeZoneAbbreviation =  'KT' Then 2           
                                        		 	When TimeZoneAbbreviation =  'HT' Then 3           
                                         			When TimeZoneAbbreviation =  'ST' Then 4
	
	                                         		When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -2 Else -3 End) 
        		                                 		When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then -1 Else -2 End) 
                		                         		When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 0 Else -1 End) 
                        		                 		When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 1 Else 0 End) 
                                		         		When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 2 Else 1 End) 
                                        		 	When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 3 Else 2 End) 
	                                         		When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 4 Else 3 End) 
        	                                	 		When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between @DayLightStartDate and @DayLightEndDate Then 5 Else 4 End)
							  END ), DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime )
*/
                                                       	            
	-- update the count stats

--**************************************************************************************************************************************************************************************
	-- All Referrals Count
--***************************************************************************************************************************************************************************************
            UPDATE   #_Temp_Referral_HospitalReport
	    SET      AllTypes = CountTable.ReferralCount
	    FROM		
	    (
            SELECT   CallSourceCodeID, ReferralCallerOrganizationID, 
	             Count(ReferralID) AS ReferralCount
	    FROM     #_Temp_Referral_TimeRangeSelect

          GROUP BY   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- AppropriateOrgan
--**************************************************************************************************************************************************************************************
	   UPDATE		#_Temp_Referral_HospitalReport
	   SET		AppropriateOrgan = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralID) AS ReferralCount
           FROM		#_Temp_Referral_TimeRangeSelect
	   WHERE	ReferralOrganAppropriateID = 1
	
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateBone
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_HospitalReport
	   SET		AppropriateBone = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 

		        Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_TimeRangeSelect
	   WHERE	ReferralBoneAppropriateID = 1
           GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateTissue
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_HospitalReport
	   SET		AppropriateTissue = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
			Count(ReferralID) AS ReferralCount
	   FROM		#_Temp_Referral_TimeRangeSelect
	   WHERE	ReferralTissueAppropriateID = 1
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND		HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND		YearID = @YearID
	   AND		MonthID = @MonthID
		
--**************************************************************************************************************************************************************************************
	-- AppropriateSkin
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_HospitalReport
	   SET		AppropriateSkin = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT 	CallSourceCodeID, ReferralCallerOrganizationID, 
	         	Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_TimeRangeSelect
	   WHERE   ReferralSkinAppropriateID = 1
	   GROUP BY 	CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateValves 
--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_HospitalReport
	   SET	AppropriateValves = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID, 
		      Count(ReferralID) AS ReferralCount
	   FROM	   #_Temp_Referral_TimeRangeSelect
	   WHERE   ReferralValvesAppropriateID = 1
	   GROUP BY CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateEyes

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_HospitalReport
	   SET	AppropriateEyes = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT     CallSourceCodeID, ReferralCallerOrganizationID, 
		      Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_TimeRangeSelect
	   WHERE   ReferralEyesTransAppropriateID = 1
	   GROUP BY  CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--**************************************************************************************************************************************************************************************
	-- AppropriateOther

--**************************************************************************************************************************************************************************************
	   UPDATE	#_Temp_Referral_HospitalReport
	   SET	AppropriateOther = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID, 
         	   Count(ReferralID) AS ReferralCount  
	   FROM	   #_Temp_Referral_TimeRangeSelect
	   WHERE   ReferralEyesRschAppropriateID = 1
	   GROUP BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID


--**************************************************************************************************************************************************************************************
	-- AppropriateAllTissue
--**************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_HospitalReport
	   SET	   AppropriateAllTissue = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT  CallSourceCodeID, ReferralCallerOrganizationID, 
		   Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_TimeRangeSelect
	   WHERE   (ReferralBoneAppropriateID = 1
	   OR	   ReferralTissueAppropriateID = 1
	   OR	   ReferralSkinAppropriateID = 1
	   OR	   ReferralValvesAppropriateID = 1)
	   GROUP BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

--************************************************************************************************************************************************************************************
	-- AppropriateRO Rule Out
--***************************************************************************************************************************************************************************************
	   UPDATE  #_Temp_Referral_HospitalReport
	   SET	   AppropriateRO = CountTable.ReferralCount
	   FROM		
	   (
	   SELECT   CallSourceCodeID, ReferralCallerOrganizationID, 
		   Count(ReferralID) AS ReferralCount 
	   FROM	   #_Temp_Referral_TimeRangeSelect
	   WHERE   (ReferralOrganAppropriateID <> 1 
	   AND	   ReferralBoneAppropriateID <> 1
	   AND	   ReferralTissueAppropriateID <> 1
	   AND	   ReferralSkinAppropriateID <> 1
	   AND	   ReferralValvesAppropriateID <> 1
	   AND	   ReferralEyesTransAppropriateID <>1
	   AND	   ReferralEyesRschAppropriateID <>1)
	   GROUP BY 	   CallSourceCodeID, ReferralCallerOrganizationID
	   ) AS    CountTable
	   WHERE	SourceCodeID = CountTable.CallSourceCodeID
	   AND 		OrganizationID = CountTable.ReferralCallerOrganizationID
	   AND	   HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID
	   AND	   YearID = @YearID
	   AND	   MonthID = @MonthID

           SET @CurrentHospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID + 1
           SET @CurrentTimeStart= (Select TimeRangeStart From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)
	   SET @CurrentTimeEnd= (Select TimeRangeEnd From HospitalReportTimeRange WHERE HospitalReportTimeRangeID = @CurrentHospitalReportTimeRangeID)

      END

--**************************************************************************************************************************************************************************************
	-- Transfer to table Referral_CallerPersonCount
--***************************************************************************************************************************************************************************************
     
	-- Delete any records for the given month and year
	DELETE 	Referral_HospitalReportTimeCount
	WHERE 	MonthID = @MonthID
	AND	YearID = @YearID

	--Update the count statistics
	INSERT INTO Referral_HospitalReportTimeCount
	SELECT * FROM #_Temp_Referral_HospitalReport 

	ORDER BY YearID, MonthID, SourceCodeID, OrganizationID, HospitalReportTimeRangeID

        DROP TABLE #_Temp_Referral_TimeRangeSelect             
	DROP TABLE #_Temp_Referral_HospitalReport
        DROP TABLE #ReportTimeCalcTable 























GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

