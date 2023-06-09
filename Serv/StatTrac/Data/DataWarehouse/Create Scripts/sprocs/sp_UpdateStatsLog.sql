SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UpdateStatsLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UpdateStatsLog]
GO


CREATE PROCEDURE sp_UpdateStatsLog
	
	@Process	int		= 0,
	@ProcessData	varchar(100)	= null,
	@ID		int		= 0

 AS

	DECLARE 	@ReturnValue	int,
			@SQLStatement varchar(5000),
			@CurrentTime	datetime

SET NOCOUNT ON
		
-- Case 0 Exit Procedure
IF @Process =  0 
	BEGIN
		 RETURN
	END
-- Case 1 Insert a new record into Table _StatsLog (dont forget to return the new record ID)
IF @Process =  1 
	BEGIN
		INSERT _UpdateStatsLog (UpdateStatsLogSP, UpdateStatsLogStart) VALUES(@ProcessData, GetDate() )
		SET @ReturnValue = @@IDENTITY
		RETURN @ReturnValue
	END
-- Case 2 Update record with number of months
IF @Process = 2 
	BEGIN	
		UPDATE 	_UpdateStatsLog
		SET		UpdateStatsLogNumMonths = CAST(@ProcessData AS int)
		WHERE	UpdateStatsLogID = @ID
	END	
-- Case 3 Update record with each of the month and years


IF @Process = 3 
	BEGIN
		
		SET @SQLStatement = (SELECT UpdateStatsLogMYList FROM _UpdateStatsLog WHERE UpdateStatsLogID = @ID)
		IF @SQLStatement is null SET @SQLStatement = ' '

select ISNULL(@SQLStatement, '') +  ISNULL(@ProcessData, '') + ', '

		UPDATE 	_UpdateStatsLog
		SET		UpdateStatsLogMYList = ISNULL(@SQLStatement, '') +  ISNULL(@ProcessData, '') + ', '
		WHERE	UpdateStatsLogID = @ID
	END
-- Case 4 Update record with run time duration and success.


IF @Process = 4 
	BEGIN
		SET @SQLStatement = (SELECT UpdateStatsLogStart FROM _UpdateStatsLog WHERE UpdateStatsLogID = @ID)
		SET @CurrentTime = GetDate()

		UPDATE 	_UpdateStatsLog
		SET		UpdateStatsLogDuration = (CAST((DATEDIFF(n, @SQLStatement, @CurrentTime)/60) AS varchar) + ':' + CAST((DATEDIFF(mi, @SQLStatement, @CurrentTime) % 60) AS varchar) + ':' + LEFT(CAST((DATEDIFF(ss, @SQLStatement, @CurrentTime) % 60) AS varchar),2)),
		--SET		UpdateStatsLogDuration = (@Hour + ':' + @Minute + ':' + @Second ),
				UpdateStatsLogEnd = @CurrentTime,
				UpdateStatsLogResults = @ProcessData
		WHERE	UpdateStatsLogID = @ID
	END
























GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

