if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_TimeZoneDifference]') and xtype in (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'Dropping function fn_TimeZoneDifference'
	drop function [dbo].[fn_TimeZoneDifference]
END
GO

PRINT 'Creating function fn_TimeZoneDifference'
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE FUNCTION dbo.fn_TimeZoneDifference
	(
	@timeZone VARCHAR(2),
	@activityDate DATETIME
	)
RETURNS INT
AS
/******************************************************************************
**		File: fn_TimeZoneDifference.sql
**		Name: fn_TimeZoneDifference
**		Desc: 
**			Determines if a Date is a DayLightSavings Date or Standard Time date. 
**			For Time Zones that do not follow daylight savings 
**			the time difference is adjusted during daylight savings.
**			If a region does not follow daylight savings is in the Eastern Time Zone
**			then during daylight savings there time difference is only 1 hour.
**
**              
**		Return values:
** 
**		Called by:   
**		GetLogEventList
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Bret Knoll
**		Date: 06/11/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		6/11/07		Bret Knoll			8.4.3.9 LogEventNumber
**		08/24/2011	ccarroll	        Changed to TimeZone table values
*******************************************************************************/
BEGIN

     DECLARE      
		@startDate varchar(20),
        @endDate   varchar(20),
        @startMonth datetime,
        @endMonth datetime,
		@calculatedTimeZone	int
	
		
	SET 
		@calculatedTimeZone = 
                    CASE @timeZone
                    When 'AT' Then 3                    
                    When 'ET' Then 2
                    When 'CT' Then 1
                    When 'MT' Then 0
                    When 'AZ' Then 0
                    When 'PT' Then -1
                    When 'AK' Then -2
                    When 'HT' Then -3
                    Else 0                                                              
                    END 
	-- @TimeZone will have -1 added to the time zone making it correct when we are observing DST 
    -- For Example: HT(-3) becomes HT(-4) when we observe DST and HT(-3) when we are not.

	-- Exceptions: the following do not observe daylight savings time
     IF @timeZone IN ('HT','AZ')
      
          
     BEGIN
    -- SET THE BEGINING AND END MONTHS
		 SET
			@startMonth =	'3/1/' + CONVERT(
												VARCHAR(4),
												DATEPART(
															YYYY, 
															@activityDate
														)
											)
									+ ' 02:00'			
		SET											
            @endMonth	=	'11/1/' + CONVERT(
												VARCHAR(4),
												DATEPART(
															YYYY, 
															@activityDate
														)
											)
									+ ' 02:00'														
         
         -- DETERMINE THE START AND END DATES   
         SET
			@StartDate = DateAdd(
									d, -- add day
									(
										(case 
											when 
												-- start of month starts on first weekday
												DATEPART(
															dw, 
															@startMonth
														) = 1 
											THEN 
												1  
											ELSE  
												8 end 
										 ) - 
											DATEPART(
													dw, 
													@startMonth
													) + 7
									),  -- how many days
									@startMonth --- date to add to
								) 
		SET	
			@endDate = DateAdd(
								d, -- add a day
								(
									(case 
										when 
											-- start of month starts on first weekday
											DATEPART(
														dw, 
														@endMonth
													) = 1 
										THEN	
											1 
										ELSE  
											8 end 
									 ) - 
										DATEPART(
													dw, 
													@endMonth
												 ) 
								), -- how many days
								@endMonth 
							  ) -- date to add
            
          -- Compare start and end date and add a -1
          
          IF @activityDate BETWEEN @StartDate AND @endDate
          BEGIN
               SET @calculatedTimeZone = @calculatedTimeZone - 1
          
          END
          
    END  

	RETURN @calculatedTimeZone
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

