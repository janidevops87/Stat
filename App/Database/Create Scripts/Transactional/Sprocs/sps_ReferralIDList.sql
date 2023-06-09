SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_ReferralIDList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_ReferralIDList]
GO




CREATE PROCEDURE sps_ReferralIDList

     @pvReportGroupID     int          = null,
     @pvStartDate         datetime     = null,  
     @pvEndDate           datetime     = null,
     @pvOrgID             int          = null,
     @vTZ                 varchar(2)   = null,
     @pvUserOrgID	  int	       = null,
     @CurrentTimeStart    int          = null,
     @CurrentTimeEnd      int          = null	 

--with recompile
AS

     DECLARE @QueryString varchar(8000)
     DECLARE @ReferralTypeStart int
     DECLARE @ReferralTypeEnd int
     DECLARE @TZ int          
     DECLARE @SourceCodeID int
     DECLARE @SCIList varchar(2000)

     CREATE TABLE #ReportTimeCalcTable
     (
     [ReportTimeCalcTableID][int]NULL,
     [DeathHour][int]NULL,
     [DeathMinute][int]NULL
     )
     
     Exec spf_TZDif @vTZ, @TZ OUTPUT, @pvStartDate
  
     SELECT @pvStartDate = DateAdd(hour,-@TZ,@pvStartDate)
     SELECT @pvEndDate = DateAdd(hour,-@TZ,@pvEndDate)     

     --SELECT @pvStartDate
     --SELECT @pvEndDate

     -- build sourcecode list
 	--DECLARE SourceCodeCursor CURSOR FOR
        Select @SCIList = ""
		IF @pvUserOrgID = 194
			BEGIN
                                DECLARE SourceCodeCursor CURSOR FOR
				SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode 
                                
			END
		ELSE
			BEGIN
                                DECLARE SourceCodeCursor CURSOR FOR
				SELECT DISTINCT SourceCodeID FROM WebReportGroupSourceCode WHERE WebReportGroupID = @pvReportGroupID
			END
	OPEN SourceCodeCursor

	FETCH NEXT FROM SourceCodeCursor 
	INTO @SourceCodeID
	 
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		
                SELECT @SCIList = @SCIList +  RTRIM(convert(char(10),@SourceCodeID))
		FETCH NEXT FROM SourceCodeCursor 
		INTO @SourceCodeID
		
		IF @@FETCH_STATUS = 0
		BEGIN
                
                        SELECT @SCIList = @SCIList + ","		
		END
		
	END

	CLOSE SourceCodeCursor
	DEALLOCATE SourceCodeCursor

     --SELECT @SCIList
     -- SELECT * FROM #SourceCodeLookUP
     -- select * from  #ReportTimeCalcTable
     -- sp_help referral

     IF @pvOrgID = 0 
     BEGIN
          INSERT #ReportTimeCalcTable
          (ReportTimeCalcTableID, DeathHour, DeathMinute)
              SELECT  ReferralID, 
                 convert(int, substring( ReferralDonorDeathTime, 1, 2 )) ,
                 convert(int,substring( ReferralDonorDeathTime, 4, 2 ))

              FROM     _ReferralProdReport..Referral
              JOIN     _ReferralProdReport..Call ON _ReferralProdReport..Call.CallID = _ReferralProdReport..Referral.CallID         
              JOIN     _ReferralProdReport..Organization ON _ReferralProdReport..Organization.OrganizationID = _ReferralProdReport..Referral.ReferralCallerOrganizationID               
              JOIN     WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
			  LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
              WHERE    DATEADD(hour, (CASE WHEN TimeZone.TimeZoneAbbreviation = 'ET' THEN 2 WHEN TimeZone.TimeZoneAbbreviation = 'CT' THEN 1 WHEN TimeZone.TimeZoneAbbreviation = 'MT' THEN 0 WHEN TimeZone.TimeZoneAbbreviation = 'PT' THEN -1 END ), CallDateTime) 
                         BETWEEN @pvStartDate AND      @pvEndDate
              AND      ReferralDonorDeathDate IS NOT NULL
              AND      LEN(ReferralDonorDeathTime)= 8
              AND      SUBSTRING(ReferralDonorDeathTime,3,1) = ':' 
              AND      WebReportGroupOrg.WebReportGroupID = @pvReportGroupID

               SELECT DISTINCT ReferralID
               FROM Call 
               JOIN Referral ON Referral.CallID = Call.CallID 
               JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
               JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
               JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
			   LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
               
               JOIN #ReportTimeCalcTable ON #ReportTimeCalcTable.ReportTimeCalcTableID = Referral.ReferralID 
               WHERE CallDateTime BETWEEN @pvStartDate AND @pvEndDate
               AND      WebReportGroupOrg.WebReportGroupID = @pvReportGroupID
               AND      CASE TimeZone.TimeZoneAbbreviation 
               WHEN 'ET' THEN DateDiff( hour, DateAdd( hour,-2, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               WHEN 'CT' THEN DateDiff( hour, DateAdd( hour,-1, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               WHEN 'MT' THEN DateDiff( hour, DateAdd( hour, 0, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               WHEN 'PT' THEN DateDiff( hour, DateAdd( hour, 1, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               END      BETWEEN @CurrentTimeStart AND  @CurrentTimeEnd 
               AND      WebReportGroupOrg.WebReportGroupID = @pvReportGroupID
      END

     IF @pvOrgID > 0 
     BEGIN
          INSERT #ReportTimeCalcTable
          (ReportTimeCalcTableID, DeathHour, DeathMinute)
              SELECT  ReferralID, 
                 convert(int, substring( ReferralDonorDeathTime, 1, 2 )) ,
                 convert(int,substring( ReferralDonorDeathTime, 4, 2 ))

              FROM     _ReferralProdReport..Referral
              JOIN     _ReferralProdReport..Call ON _ReferralProdReport..Call.CallID = _ReferralProdReport..Referral.CallID         
              JOIN     _ReferralProdReport..Organization ON _ReferralProdReport..Organization.OrganizationID = _ReferralProdReport..Referral.ReferralCallerOrganizationID               
              JOIN     WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID
			   LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
              WHERE    DATEADD(hour, (CASE WHEN TimeZone.TimeZoneAbbreviation = 'ET' THEN 2 WHEN TimeZone.TimeZoneAbbreviation = 'CT' THEN 1 WHEN TimeZone.TimeZoneAbbreviation = 'MT' THEN 0 WHEN TimeZone.TimeZoneAbbreviation = 'PT' THEN -1 END ), CallDateTime) 
                         BETWEEN @pvStartDate AND @pvEndDate
              AND      ReferralDonorDeathDate IS NOT NULL
              AND      LEN(ReferralDonorDeathTime)= 8
              AND      SUBSTRING(ReferralDonorDeathTime,3,1) = ':' 
              AND      Referral.ReferralCallerOrganizationID = @pvOrgID
              AND      WebReportGroupOrg.WebReportGroupID = @pvReportGroupID

               SELECT DISTINCT ReferralID
               FROM Call 
               JOIN Referral ON Referral.CallID = Call.CallID 
               JOIN Organization ON Organization.OrganizationID = Referral.ReferralCallerOrganizationID 
               JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = ReferralCallerOrganizationID 
               JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 
			   LEFT JOIN TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID
               JOIN #ReportTimeCalcTable ON #ReportTimeCalcTable.ReportTimeCalcTableID = Referral.ReferralID 
               WHERE CallDateTime BETWEEN @pvStartDate AND @pvEndDate
               AND      WebReportGroupOrg.WebReportGroupID = @pvReportGroupID
               AND      CASE TimeZone.TimeZoneAbbreviation 
               WHEN 'ET' THEN DateDiff( hour, DateAdd( hour,-2, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               WHEN 'CT' THEN DateDiff( hour, DateAdd( hour,-1, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               WHEN 'MT' THEN DateDiff( hour, DateAdd( hour, 0, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               WHEN 'PT' THEN DateDiff( hour, DateAdd( hour, 1, DateAdd( hour, DeathHour, Dateadd( minute, DeathMinute, ReferralDonorDeathDate ))), CallDateTime ) 
               END      BETWEEN @CurrentTimeStart AND  @CurrentTimeEnd 
               AND      Referral.ReferralCallerOrganizationID = @pvOrgID
               AND      WebReportGroupOrg.WebReportGroupID = @pvReportGroupID
    END
     --select @QueryString
     --EXEC(@QueryString )

     DROP TABLE #ReportTimeCalcTable



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

