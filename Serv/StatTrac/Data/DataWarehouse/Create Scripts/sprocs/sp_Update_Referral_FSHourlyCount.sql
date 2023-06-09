SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Update_Referral_FSHourlyCount]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Update_Referral_FSHourlyCount]
GO






CREATE PROCEDURE sp_Update_Referral_FSHourlyCount
AS

	DECLARE		@YearID			int,
			@MonthID		int,
			@LastUpdated		datetime,
			@Updated		smallint,
			@SPName			varchar(50),
			@String			varchar(8),
			@ID 			int,
                        @DayLightStartDate      datetime,
                        @DayLightEndDate        datetime,
                        @LoopCounter            int,
                        @ArchiveDate		datetime

    
	SET		@SPName = 'Referral_FSHourlyCount'


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
	--only the current month is updated for this sproc
		--Add month / year to UpdateStatLog
		select @MonthID = datepart(m, dateadd(d,-1,getdate()))
		select @YearID = datepart(yyyy, dateadd(d,-1,getdate()))
		SET @String =  (Cast(@MonthID AS varchar) + '/'+ Cast(@YearID AS varchar))
		
		EXECUTE sp_UpdateStatsLog 3, @String,  @ID
		--Update stats table for all available dates
		EXECUTE spi_Referral_FSHourlyCount @MonthID, @YearID
		
	

--if the table was updated, set the update completed time
--if @Updated = 1
--BEGIN
	--Update the last updated field 
	UPDATE	_Table_LastUpdate
	SET		UpdateCompleted = getdate()
	WHERE	TableName = @SPName
--END

/*
	insert _Table_LastUpdate (TableName,LastUpdated)
	values('Referral_FSHourlyCount', '8/10/06')
*/
--Close out UpdateStatsLog
	Execute sp_UpdateStatsLog 4, 1, @ID
































GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

