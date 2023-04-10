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
	@LoopCounter		int;

DROP TABLE IF EXISTS #DayLight_Temp;

CREATE TABLE #DayLight_Temp
(
    YearID				int,
    DayLightStartDate	datetime,
    DayLightEndDate		datetime
);
        
-- loop through years starting with current ending with 1996                          
SELECT @LOOPCounter = DATEPART(yyyy, GETDATE());

WHILE @LoopCounter > 2019
    BEGIN
		EXEC spf_GetDayLightDates @LoopCounter, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT;

        INSERT #DayLight_Temp (YearID, DayLightStartDate, DayLightEndDate)
        VALUES (@LoopCounter, @DayLightStartDate, @DayLightEndDate);

        SELECT @LoopCounter = @LoopCounter -1;
    END; -- END WHILE LOOP

--Create a new record in the UpdateStatsLog Table
SET @SPName = 'Referral_HospitalReportTimeCount';
SET @Updated = 0;
EXECUTE @ID = sp_UpdateStatsLog 1, @SPName;

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
		vwDataWarehouseCall.CallDateTime >= '2020-03-01 00:00:00'
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

		EXECUTE sp_UpdateStatsLog 3, @String,  @ID;
		EXECUTE spi_Referral_HospitalReportTimeCount @MonthID, @YearID;

		FETCH NEXT FROM modified_cursor INTO @MonthID, @YearID;
	END;

DEALLOCATE modified_cursor;

DROP TABLE IF EXISTS #DayLight_Temp;