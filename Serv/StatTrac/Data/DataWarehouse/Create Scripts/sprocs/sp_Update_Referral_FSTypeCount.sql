SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Update_Referral_FSTypeCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Update_Referral_FSTypeCount]
GO



CREATE PROCEDURE sp_Update_Referral_FSTypeCount AS

DECLARE	@YearID			INT,
	@MonthID		INT,
	@LastUpdated		DATETIME,
	@Updated		SMALLINT,
	@SPName			VARCHAR(50),
	@String			VARCHAR(8),
	@ID 			INT,
	@DayLightStartDate      DATETIME,
	@DayLightEndDate        DATETIME,
	@LoopCounter            INT,
	@ArchiveDate		DATETIME
	
CREATE TABLE #DayLight(YearID            INT,                                                      --Create Holding table for Daylight Savings Information
                       DayLightStartDate DATETIME,
                       DayLightEndDate   DATETIME) 
        
SELECT @LOOPCounter = DATEPART(yyyy, GETDATE())                                                    --loop through years starting with current ending with 1996
WHILE @LoopCounter > 1995
  BEGIN
    EXEC spf_GetDayLightDates @LoopCounter, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT
    INSERT #DayLight(YearID,        DayLightStartDate,  DayLightEndDate)
    VALUES          (@LoopCounter, @DayLightStartDate, @DayLightEndDate)
    SELECT @LoopCounter = @LoopCounter -1                  
  END

SET @SPName = 'Referral_FSTypeCount'
SET @Updated = 0

Execute @ID = sp_UpdateStatsLog 1, @SPName                                                         --Create a new record in the UpdateStatsLog Table

SELECT @LastUpdated = LastUpdated                                                                  --First get the last time the table stats were updated
FROM _Table_LastUpdate
WHERE TableName = @SPName
SELECT @LastUpdated = ISNULL(@LastUpdated,0)

--SELECT @ArchiveDate = DateAdd(d,1,MAX(TableDate)) FROM _ReferralProdReport.dbo.ArchiveStatus
SELECT @ArchiveDate = DateAdd(d,1,MAX(TableDate)) FROM _ReferralProdReport.dbo.ArchiveStatus                               --set @ArchivDate
SELECT @ArchiveDate = ISNULL(@ArchiveDate,0)

DECLARE c CURSOR FOR                                                                               --Create cursor for the modified month and year list
  SELECT DISTINCT DATEPART(m, DATEADD(hour, (CASE WHEN TimeZoneAbbreviation =  'AT' THEN 3        
                                                  WHEN TimeZoneAbbreviation =  'ET' THEN 2          
                                                  WHEN TimeZoneAbbreviation =  'CT' THEN 1          
                                                  WHEN TimeZoneAbbreviation =  'MT' THEN 0
                                                  WHEN TimeZoneAbbreviation =  'PT' THEN -1          
                                                  WHEN TimeZoneAbbreviation =  'KT' THEN -2           
                                                  WHEN TimeZoneAbbreviation =  'HT' THEN -3           
                                                  WHEN TimeZoneAbbreviation =  'ST' THEN -4
                                                  WHEN TimeZoneAbbreviation =  'AS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN 2 Else 3 End) 
                                                  WHEN TimeZoneAbbreviation =  'ES' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN 1 Else 2 End) 
                                                  WHEN TimeZoneAbbreviation =  'CS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN 0 Else 1 End) 
                                                  WHEN TimeZoneAbbreviation =  'MS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN -1 Else 0 End) 
                                                  WHEN TimeZoneAbbreviation =  'PS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN -2 Else -1 End) 
                                                  WHEN TimeZoneAbbreviation =  'KS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime))  THEN -3 Else -2 End) 
                                                  WHEN TimeZoneAbbreviation =  'HS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime))  THEN -4 Else -3 End) 
                                                  WHEN TimeZoneAbbreviation =  'SS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime))  THEN -5 Else -4 End) 
                                              END), c.CallDateTime)) AS MonthID,
                  DATEPART(yyyy, DATEADD(hour, (CASE WHEN TimeZoneAbbreviation =  'AT' THEN 3        
                                                     WHEN TimeZoneAbbreviation =  'ET' THEN 2          
                                                     WHEN TimeZoneAbbreviation =  'CT' THEN 1          
                                                     WHEN TimeZoneAbbreviation =  'MT' THEN 0
                                                     WHEN TimeZoneAbbreviation =  'PT' THEN -1          
                                                     WHEN TimeZoneAbbreviation =  'KT' THEN -2           
                                                     WHEN TimeZoneAbbreviation =  'HT' THEN -3           
                                                     WHEN TimeZoneAbbreviation =  'ST' THEN -4
                                                     WHEN TimeZoneAbbreviation =  'AS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN 2 Else 3 End) 
                                                     WHEN TimeZoneAbbreviation =  'ES' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN 1 Else 2 End) 
                                                     WHEN TimeZoneAbbreviation =  'CS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN 0 Else 1 End) 
                                                     WHEN TimeZoneAbbreviation =  'MS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN -1 Else 0 End) 
                                                     WHEN TimeZoneAbbreviation =  'PS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) THEN -2 Else -1 End) 
                                                     WHEN TimeZoneAbbreviation =  'KS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime))  THEN -3 Else -2 End) 
                                                     WHEN TimeZoneAbbreviation =  'HS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime))  THEN -4 Else -3 End) 
                                                     WHEN TimeZoneAbbreviation =  'SS' THEN (CASE WHEN c.CallDateTime BETWEEN (SELECT DayLightStartDate FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime)) AND (SELECT DayLightEndDate  FROM #DayLight WHERE YearID = DatePart(yyyy,CallDateTime))  THEN -5 Else -4 End) 
                                                END), c.CallDateTime)) AS YearID
  FROM _ReferralProdReport.dbo.Organization o 
  INNER JOIN _ReferralProdReport.dbo.Referral r ON o.OrganizationID = r.ReferralCallerOrganizationID 
  RIGHT OUTER JOIN _ReferralProdReport.dbo.Call c 
  RIGHT OUTER JOIN _ReferralProdReport.dbo.FSCase fsc ON c.CallID = fsc.CallID ON r.CallID = fsc.CallID
  JOIN _ReferralProdReport.dbo.TimeZone ON o.TimeZoneID = _ReferralProdReport.dbo.TimeZone.TimeZoneID
				-- ccarroll 07/29/2011 Added Join to TimeZone  

  WHERE	c.CallDateTime >= @ArchiveDate
  AND	(c.LastModified > @LastUpdated OR r.LastModified  > @LastUpdated)
  ORDER BY YearID, MonthID

--FROM		_ReferralProdReport.dbo.Call
--JOIN		_ReferralProdReport.dbo.Referral ON _ReferralProdReport.dbo.Referral.CallID = _ReferralProdReport.dbo.Call.CallID
--JOIN		_ReferralProdReport.dbo.Organization ON _ReferralProdReport.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdReport.dbo.Organization.OrganizationID	
--WHERE	
--		_ReferralProdReport.dbo.Call.CallDateTime >= @ArchiveDate
--AND
--		(_ReferralProdReport.dbo.Call.LastModified > @LastUpdated
--OR		_ReferralProdReport.dbo.Referral.LastModified  > @LastUpdated
--		)
--ORDER BY 	 YearID, MonthID

OPEN c
EXEC sp_UpdateStatsLog 2, @@Cursor_Rows, @ID                                                       --update UpdateStatsLog with number of months
FETCH NEXT FROM c INTO @MonthID, @YearID
PRINT CONVERT(VARCHAR(2000),@YearID) + ' ' + CONVERT(VARCHAR(2000),@MonthID)
IF @@fetch_status = 0 SET @Updated = 1
IF @Updated = 1
  BEGIN
    UPDATE _Table_LastUpdate                                                                       --Update the last updated field
    SET LastUpdated = getdate()
    WHERE TableName = @SPName
  END
	
WHILE @@fetch_status = 0
  BEGIN
    SET @String =  (Cast(@MonthID AS varchar) + '/'+ Cast(@YearID AS varchar))                     --Add month / year to UpdateStatLog
    IF (CAST(@MonthID AS VARCHAR)+ '/1/' + CAST(@YearID AS VARCHAR)) >= @ArchiveDate 
      BEGIN
        EXECUTE sp_UpdateStatsLog 3, @String,  @ID
        EXECUTE spi_Referral_FSTypeCount @YearID, @MonthID
      END	
      FETCH NEXT FROM c INTO @MonthID, @YearID
  END

CLOSE c DEALLOCATE c	

IF @Updated = 1                                                                                    --if the table was updated, set the update completed time
  BEGIN
    UPDATE _Table_LastUpdate                                                                       --Update the last updated field
    SET	UpdateCompleted = getdate()
    WHERE TableName = @SPName
  END

DROP TABLE #DayLight

EXEC sp_UpdateStatsLog 4, 1, @ID                                                                   --Close out UpdateStatsLog












GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

