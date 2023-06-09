SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects where id = object_id(N'[dbo].[sp_Update_Referral_HospitalReportTimeCount]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	DROP PROCEDURE [dbo].[sp_Update_Referral_HospitalReportTimeCount];
GO

CREATE PROCEDURE sp_Update_Referral_HospitalReportTimeCount AS
/******************************************************************************
**		File: sp_Update_Referral_HospitalReportTimeCount.sql
**		Name: sp_Update_Referral_HospitalReportTimeCount.sql
**		Desc: Updates the Referral_HospitalReportTimeCount table in DataWarehouse
**
**
**		Auth: ??
**		Date: ??
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/20/2021	James Gerberich		Changed to correctly refernce TimeZone table values
*******************************************************************************/

DECLARE
	@YearID				int,
	@MonthID			int,
	@LastUpdated		datetime,
	@Updated			smallint,
	@SPName				varchar(50),
	@String				varchar(8),
	@ID					int,
	@DayLightStartDate	datetime,
	@DayLightEndDate	datetime,
	@LoopCounter		int,
	@ArchiveDate		datetime;

--Create Holing table for Daylight Savings Information
DROP TABLE IF EXISTS #DayLight_Temp;
CREATE TABLE #DayLight_Temp
(
    YearID				int,
    DayLightStartDate	datetime,
    DayLightEndDate		datetime
);
        
-- loop through years starting with current ending with 1996                          
SELECT @LOOPCounter = DATEPART(yyyy, GETDATE());

WHILE @LoopCounter > 1995
    BEGIN
		EXEC spf_GetDayLightDates @LoopCounter, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT;

        INSERT #DayLight_Temp (YearID, DayLightStartDate, DayLightEndDate)
        VALUES (@LoopCounter, @DayLightStartDate, @DayLightEndDate);

        SELECT @LoopCounter = @LoopCounter -1;
    END; -- END WHILE LOOP

SET @SPName = 'Referral_HospitalReportTimeCount';
SET @Updated = 0;

--First get the last time the table stats were updated
SELECT	@LastUpdated = LastUpdated
FROM	_Table_LastUpdate
WHERE	TableName = @SPName;

--Create a new record in the UpdateStatsLog Table
EXECUTE @ID = sp_UpdateStatsLog 1, @SPName;

-- set @ArchiveDate
SELECT @ArchiveDate = DATEADD(d,1,MAX(TableDate)) FROM vwDataWarehouseArchiveStatus;

--Create cursor for the modified month and year list
DECLARE modified_cursor CURSOR FOR
	SELECT DISTINCT
		DATEPART(m, DATEADD(hour,
			(CASE
				WHEN TimeZoneAbbreviation = 'AT' THEN 3
				WHEN TimeZoneAbbreviation = 'ET' THEN 2
				WHEN TimeZoneAbbreviation = 'CT' THEN 1
				WHEN TimeZoneAbbreviation = 'MT' THEN 0
				WHEN TimeZoneAbbreviation = 'PT' THEN -1
				WHEN TimeZoneAbbreviation = 'AK' THEN -2
				WHEN TimeZoneAbbreviation = 'ST' THEN -4
				--Arizona and Hawaii do not observe Daylight Savings time
				WHEN TimeZoneAbbreviation = 'AZ' THEN (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) AND (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -1 Else 0 End)
				WHEN TimeZoneAbbreviation = 'HT' THEN (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) AND (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -4 Else -3 End)
			END), CallDateTime)) AS MonthID,
		DATEPART(yyyy, DATEADD(hour,
			(CASE
				WHEN TimeZoneAbbreviation = 'AT' THEN 3
				WHEN TimeZoneAbbreviation = 'ET' THEN 2
				WHEN TimeZoneAbbreviation = 'CT' THEN 1
				WHEN TimeZoneAbbreviation = 'MT' THEN 0
				WHEN TimeZoneAbbreviation = 'PT' THEN -1
				WHEN TimeZoneAbbreviation = 'AK' THEN -2
				WHEN TimeZoneAbbreviation = 'ST' THEN -4
				--Arizona and Hawaii do not observe Daylight Savings time
				WHEN TimeZoneAbbreviation = 'AZ' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -1 Else 0 End)
				WHEN TimeZoneAbbreviation = 'HT' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -4 Else -3 End)
			END), CallDateTime)) AS YearID
	FROM
		vwDataWarehouseCall
		JOIN vwDataWarehouseReferral ON vwDataWarehouseReferral.CallID = vwDataWarehouseCall.CallID
		JOIN vwDataWarehouseOrganization ON vwDataWarehouseReferral.ReferralCallerOrganizationID = vwDataWarehouseOrganization.OrganizationID
		JOIN vwDataWarehouseTimeZone ON vwDataWarehouseOrganization.TimeZoneID = vwDataWarehouseTimeZone.TimeZoneID
	WHERE
		vwDataWarehouseCall.CallDateTime >= @ArchiveDate
	AND	(
			vwDataWarehouseCall.LastModified > @LastUpdated
		OR	vwDataWarehouseReferral.LastModified > @LastUpdated
		)
	ORDER BY
		YearID,
		MonthID;

OPEN modified_cursor
--update UpdateStatsLog with number of records
	EXECUTE sp_UpdateStatsLog 2, @@CURSOR_ROWS, @ID;
	FETCH NEXT FROM modified_cursor INTO @MonthID, @YearID;

	IF @@FETCH_STATUS = 0
		BEGIN --Flag the table as updated
			SET	@Updated = 1;
		END;

	IF @Updated = 1
		BEGIN --Update the last updated field
			UPDATE	_Table_LastUpdate
			SET		LastUpdated = GETDATE()
			WHERE	TableName = @SPName;
		END;

--Loop through list to update the table stats
	WHILE @@FETCH_STATUS = 0
		BEGIN --Add month / year to UpdateStatLog
		SET @String = (CAST(@MonthID AS varchar) + '/'+ CAST(@YearID AS varchar));

		IF (CAST(@MonthID AS varchar)+ "/1/" + CAST(@YearID AS varchar)) >= @ArchiveDate
			BEGIN --Update stats table for all available dates
				EXECUTE sp_UpdateStatsLog 3, @String,  @ID;
				EXECUTE spi_Referral_HospitalReportTimeCount @MonthID, @YearID;
			END;

	FETCH NEXT FROM modified_cursor INTO @MonthID, @YearID;
END;

DEALLOCATE modified_cursor;

--if the table was updated, set the update completed time
IF @Updated = 1
	BEGIN --Update the last updated field 
	UPDATE	_Table_LastUpdate
	SET		UpdateCompleted = GETDATE()
	WHERE	TableName = @SPName;
END;

DROP TABLE IF EXISTS #DayLight_Temp;

--Close out UpdateStatsLog
EXECUTE sp_UpdateStatsLog 4, 1, @ID;
GO

SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO