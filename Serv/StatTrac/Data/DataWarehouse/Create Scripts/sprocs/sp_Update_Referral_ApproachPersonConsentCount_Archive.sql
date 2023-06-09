SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Update_Referral_ApproachPersonConsentCount_Archive]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Update_Referral_ApproachPersonConsentCount_Archive]
GO

CREATE PROCEDURE sp_Update_Referral_ApproachPersonConsentCount_Archive AS

	Declare		@YearID			int,
			@MonthID		int,
			@LastUpdated		datetime,
			@Updated		smallint,
			@SPName		varchar(50),
			@String			varchar(8),
			@ID 			int,
                        @DayLightStartDate      datetime,
                        @DayLightEndDate        datetime,
                        @LoopCounter            int,
                        @ArchiveDate		datetime
	

        --Create Holing table for Daylight Savings Information
        Create Table #DayLight_Temp
        (
          YearID int,
          DayLightStartDate datetime,
          DayLightEndDate datetime
         ) 
        
         -- loop through years starting with current ending with 1996                          
          SELECT @LOOPCounter = DatePart(yyyy, GetDate())
          While @LoopCounter > 1995
          BEGIN
               Exec spf_GetDayLightDates @LoopCounter, @DayLightStartDate OUTPUT, @DayLightEndDate OUTPUT

               Insert #DayLight_Temp (YearID, DayLightStartDate, DayLightEndDate)
               Values (@LoopCounter, @DayLightStartDate, @DayLightEndDate)
               
               SELECT @LoopCounter =   @LoopCounter -1                  
          END -- END WHILE LOOP

	SET		@SPName = 'Referral_ApproachPersonConsentCount_Archive'


	SET		@Updated = 0

	--First get the last time the table stats were updated
	SELECT	@LastUpdated = LastUpdated
	FROM		_Table_LastUpdate
	WHERE	TableName = @SPName

	--Create a new record in the UpdateStatsLog Table
		Execute @ID = sp_UpdateStatsLog 1, @SPName

	-- set @ArchivDate
	Select @ArchiveDate = DateAdd(d,1,MAX(TableDate)) from _ReferralProdReport.dbo.ArchiveStatus

	--Create cursor for the modified month and year list
	DECLARE modified_cursor 	cursor
	FOR

		SELECT DISTINCT
				DATEPART(m, DATEADD(hour, 
				(
				CASE
				    When TimeZoneAbbreviation =  'AT' Then 3        
                                    When TimeZoneAbbreviation =  'ET' Then 2          
                                    When TimeZoneAbbreviation =  'CT' Then 1          
                                    When TimeZoneAbbreviation =  'MT' Then 0
                                    When TimeZoneAbbreviation =  'PT' Then -1          
                                    When TimeZoneAbbreviation =  'KT' Then -2           
                                    When TimeZoneAbbreviation =  'HT' Then -3           
                                    When TimeZoneAbbreviation =  'ST' Then -4

                                    When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then 2 Else 3 End) 
                                    When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then 1 Else 2 End) 
                                    When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then 0 Else 1 End) 
                                    When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then -1 Else 0 End) 
                                    When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then -2 Else -1 End) 
                                    When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -3 Else -2 End) 
                                    When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -4 Else -3 End) 
                                    When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -5 Else -4 End) 
				END 
				), CallDateTime)) AS MonthID,
				DATEPART(yyyy, DATEADD(hour, 
				(
				CASE
				    When TimeZoneAbbreviation =  'AT' Then 3        
                                    When TimeZoneAbbreviation =  'ET' Then 2          
                                    When TimeZoneAbbreviation =  'CT' Then 1          
                                    When TimeZoneAbbreviation =  'MT' Then 0
                                    When TimeZoneAbbreviation =  'PT' Then -1          
                                    When TimeZoneAbbreviation =  'KT' Then -2           
                                    When TimeZoneAbbreviation =  'HT' Then -3           
                                    When TimeZoneAbbreviation =  'ST' Then -4

                                    When TimeZoneAbbreviation =  'AS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then 2 Else 3 End) 
                                    When TimeZoneAbbreviation =  'ES' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then 1 Else 2 End) 
                                    When TimeZoneAbbreviation =  'CS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then 0 Else 1 End) 
                                    When TimeZoneAbbreviation =  'MS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then -1 Else 0 End) 
                                    When TimeZoneAbbreviation =  'PS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) Then -2 Else -1 End) 
                                    When TimeZoneAbbreviation =  'KS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -3 Else -2 End) 
                                    When TimeZoneAbbreviation =  'HS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -4 Else -3 End) 
                                    When TimeZoneAbbreviation =  'SS' Then (Case When CallDateTime between (select DayLightStartDate from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime)) and (select DayLightEndDate  from #DayLight_Temp where YearID = DatePart(yyyy,CallDateTime))  Then -5 Else -4 End) 
				END 
				), CallDateTime)) AS YearID
		FROM		_ReferralProdArchive.dbo.Call
		JOIN		_ReferralProdArchive.dbo.Referral ON _ReferralProdArchive.dbo.Referral.CallID = _ReferralProdArchive.dbo.Call.CallID
		JOIN		_ReferralProdArchive.dbo.Organization ON _ReferralProdArchive.dbo.Referral.ReferralCallerOrganizationID = _ReferralProdArchive.dbo.Organization.OrganizationID	
		JOIN _ReferralProdArchive.dbo.TimeZone ON _ReferralProdArchive.dbo.Organization.TimeZoneID = _ReferralProdArchive.dbo.TimeZone.TimeZoneID
				-- ccarroll 07/29/2011 Added Join to TimeZone  

		WHERE	
				_ReferralProdArchive.dbo.Call.CallDateTime < @ArchiveDate
		AND

		(
				_ReferralProdArchive.dbo.Call.LastModified > @LastUpdated
		OR		_ReferralProdArchive.dbo.Referral.LastModified  > @LastUpdated
		)
		ORDER BY 	 YearID, MonthID

	OPEN	modified_cursor
	   --update UpdateStatsLog with number of months
		Execute sp_UpdateStatsLog 2, @@Cursor_Rows, @ID

	fetch next from modified_cursor into @MonthID, @YearID


	--if @@fetch_status = 0 
	--BEGIN
		--Flag the table as updated
		SET		@Updated = 1
	---END
	
	if @Updated = 1
	BEGIN
		--Update the last updated field 
		UPDATE	_Table_LastUpdate
		SET		LastUpdated = getdate()
		WHERE	TableName = @SPName
	END
	
	--Loop through list to update the table stats
	while @@fetch_status = 0
	BEGIN	
		--Add month / year to UpdateStatLog
		SET @String =  (Cast(@MonthID AS varchar) + '/'+ Cast(@YearID AS varchar))
		IF (CAST(@MonthID AS VARCHAR)+ "/1/" + CAST(@YearID AS VARCHAR)) < @ArchiveDate
		BEGIN
			EXECUTE sp_UpdateStatsLog 3, @String,  @ID
			--Update stats table for all available dates
			EXECUTE spi_Referral_ApproachPersonConsentCount_Archive @MonthID, @YearID
		END		
	fetch next from modified_cursor into @MonthID, @YearID
	END
	
	deallocate modified_cursor	

 
--if the table was updated, set the update completed time
if @Updated = 1
BEGIN
	--Update the last updated field 
	UPDATE	_Table_LastUpdate
	SET		UpdateCompleted = getdate()
	WHERE	TableName = @SPName
END


  --DROPT TEMP table #DayLight_Temp
   DROP TABLE #DayLight_Temp

--Close out UpdateStatsLog
	Execute sp_UpdateStatsLog 4, 1, @ID
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

