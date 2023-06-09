SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Update_Referral_CallCountSummary]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Update_Referral_CallCountSummary]
GO





CREATE PROCEDURE sp_Update_Referral_CallCountSummary AS

	DECLARE		
		@YearID			int,
		@MonthID		int,
		@DayID			int,
		@LastUpdated		datetime,
		@Updated		smallint,
		@SPName			varchar(50),
		@String			varchar(8),
		@ID 			int,
                        @DayLightStartDate      datetime,
                        @DayLightEndDate        datetime,
                        @LoopCounter            int,
                        @ArchiveDate		datetime

    
	SET		@SPName = 'Referral_CallCountSummary'


	SET		@Updated = 0

	--Create a new record in the UpdateStatsLog Table
		Execute @ID = sp_UpdateStatsLog 1, @SPName

		   --update UpdateStatsLog with number of months
		Execute sp_UpdateStatsLog 2, 1, @ID


		--Update the last updated field 
		UPDATE	_Table_LastUpdate
		SET		LastUpdated = getdate()
		WHERE	TableName = @SPName
	
	--Loop through list to update the table stats
		--Add month / year to UpdateStatLog
		select @MonthID = datepart(m, dateadd(d,-1,getdate()))
		select @YearID = datepart(yyyy, dateadd(d,-1,getdate()))
		SET @String =  (Cast(@MonthID AS varchar) + '/'+ Cast(@YearID AS varchar))
		
		EXECUTE sp_UpdateStatsLog 3, @String,  @ID
		SET @DayID = 1
		WHILE 
			( 
				CONVERT(DATETIME, CONVERT(VARCHAR(2), @MonthID) + '/' +  CONVERT(VARCHAR(2), @DayID) + '/' + CONVERT(VARCHAR(4), @YearID)) < DATEADD(M, 1, CONVERT(DATETIME, CONVERT(VARCHAR(2), @MonthID) + '/1/' + CONVERT(VARCHAR(4), @YearID))) 
				AND CONVERT(DATETIME, CONVERT(VARCHAR(2), @MonthID) + '/' +  CONVERT(VARCHAR(2), @DayID) + '/' + CONVERT(VARCHAR(4), @YearID)) < GETDATE()
			)
		BEGIN
			--Update stats table for all available dates
			-- LOOP HERE FOR EACH DAY IN THE CURRENT MONTH
			EXECUTE spi_Referral_CallCountSummary @DayID, @MonthID, @YearID 
			EXECUTE spi_Referral_MessageCountSummary @DayID, @MonthID, @YearID
			EXECUTE spi_Referral_FSCallCountSummary2 @DayID, @MonthID, @YearID
		
			SET @DayID = @DayID + 1
		END
		
	

--if the table was updated, set the update completed time
--if @Updated = 1
--BEGIN
	--Update the last updated field 
	UPDATE	_Table_LastUpdate
	SET		UpdateCompleted = getdate()
	WHERE	TableName = @SPName
--END

--Close out UpdateStatsLog
	Execute sp_UpdateStatsLog 4, 1, @ID































GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

