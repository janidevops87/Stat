SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_TZDif]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spf_TZDif]
GO


-- Test
/*
	DECLARE @iTZ varchar(2),
		@oTZ int,
		@CheckDate datetime
	SET @CheckDate = '11/8/07 23:59'
	SET @iTZ = 'AS'
	EXEC spf_TZDif @iTZ, @oTZ OUTPUT, @CheckDate
	SELECT @oTZ

*/

CREATE PROCEDURE spf_TZDif
     @iTZ       varchar(2),
     @oTZ       int OUTPUT,
     @CheckDate smalldatetime = null
-- Declare @result int exec spf_TZDif 'MS', @result OUTPUT, '4/4/00' SELECT @result
AS
/*
	Determines if a Date is a DayLightSavings Date or Standard Time date. 
	For Time Zones that do not follow daylight savings the time difference is adjusted during daylight savings.
	If a region that does not follow daylight savings is in the Eastern Time Zone then during daylight savings there time 
	difference is only 1 hour.

*/
     DECLARE
		@StartDate varchar(20),
        @EndDate   varchar(20),
        @LoopCount int,
		@weekCount int;

SELECT
	@oTZ = CASE @iTZ
			When 'AT' Then 3                    
			When 'AS' Then 3                    
			When 'ET' Then 2
			When 'ES' Then 2
			When 'CT' Then 1
			When 'CS' Then 1
			When 'MT' Then 0
			When 'MS' Then 0
			When 'PT' Then -1
			When 'PS' Then -1
			When 'AK' Then -2
			When 'AS' Then -2
			When 'KT' Then -2
			When 'KS' Then -2
			When 'HT' Then -3
			When 'HS' Then -3
			When 'ST' Then -4                                                              
			When 'SS' Then -4                                                              
		END

     IF RIGHT(@iTZ, 1) = 'S' 
     BEGIN --check @CheckDate if it is null assign it today's date.
		IF @CheckDate is null 
		BEGIN
		  Select @CheckDate = GetDate();
		END
          
		--get StartDate BREAK
		Select @LoopCount = 1;
		SET @weekCount = 0;
		WHILE @LoopCount < 32
			BEGIN -- daylight savings starts the second Sunday in March
				Select @StartDate = '3/' + convert(varchar(2),@LoopCount) + '/' + CONVERT(varchar(4),DATEPART(YYYY,@CheckDate))+ ' 02:00:00';
				
				IF ISDATE(@StartDate) = 1 -- is the date a valid date
				BEGIN
                    IF DATEPART(dw, @StartDate) = 1-- if the date is a sunday add to the week count
					BEGIN
						SET @weekCount = @weekCount + 1;
					END;
					IF (DATEPART(dw, @StartDate) = 1 AND @weekCount = 2)-- if the date is a sunday and the weekCount is 2 for the second week
                    BEGIN
                         Break;
                    END
               END
               SELECT @LoopCount = @LoopCount + 1;
			END
          
          --get enddate
          SET @LoopCount = 1;
          WHILE @LoopCount < 32
          BEGIN
               Select @EndDate = '11/' + convert(varchar(2),@LoopCount) + '/' + CONVERT(Varchar(4),DATEPART(YYYY,@CheckDate)) + ' 02:00:00';
               IF ISDATE(@EndDate) = 1 -- the date is a valid date
               BEGIN
					IF DATEPART(dw, @EndDate) = 1-- if the date is a sunday, it will be the first sunday in november
                    BEGIN
                         Break;
                    END     
               END
               SELECT @LoopCount = @LoopCount + 1;
          END

		  -- Compare start and end date and add a -1
          IF @CHECKDATE BETWEEN @StartDate AND @EndDate
          BEGIN
               SELECT @oTZ = @oTZ - 1;
          END
     END

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO