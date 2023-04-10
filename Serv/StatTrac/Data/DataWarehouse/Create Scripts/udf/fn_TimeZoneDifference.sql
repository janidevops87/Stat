IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[fn_TimeZoneDifference]') and xtype in (N'FN', N'IF', N'TF'))
BEGIN
	PRINT 'Dropping function fn_TimeZoneDifference';
	DROP FUNCTION [dbo].[fn_TimeZoneDifference];
END
GO

PRINT 'Creating function fn_TimeZoneDifference';
GO

SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
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
**		Called by: Multiple procedures
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
		@calculatedTimeZone	int;

	SET @calculatedTimeZone =
		CASE @timeZone
            WHEN 'AT' THEN 3
            WHEN 'ET' THEN 2
            WHEN 'CT' THEN 1
            WHEN 'MT' THEN 0
            WHEN 'AZ' THEN 0
            WHEN 'PT' THEN -1
            WHEN 'AK' THEN -2
            WHEN 'HT' THEN -3
            ELSE 0
        END;

-- @TimeZone will have -1 added to the time zone making it correct when we are observing DST
-- For Example: HT(-3) becomes HT(-4) when we observe DST and HT(-3) when we are not.
-- Exceptions: the following do not observe daylight savings time
	IF @timeZone IN ('HT','AZ')
	BEGIN
	-- SET THE BEGINING AND END MONTHS
		SET @startMonth = '3/1/' + CONVERT(VARCHAR(4), DATEPART(YYYY, @activityDate)) + ' 02:00';
		SET	@endMonth = '11/1/' + CONVERT(VARCHAR(4), DATEPART(YYYY, @activityDate)) + ' 02:00';
	-- DETERMINE THE START AND END DATES
		SET @StartDate = DATEADD(d,	(-- add days
										(-- how many days
											CASE
												WHEN DATEPART(dw, @startMonth) = 1 -- 1st of month is a Sunday
												THEN 1
												ELSE 8
											END
										 ) - DATEPART(dw, @startMonth) + 7
									), @startMonth -- date to add to
								);
		SET @endDate = DATEADD(d, (-- add days
									(-- how many days
										CASE
											WHEN DATEPART(dw, @endMonth) = 1 -- 1st of month is a Sunday
											THEN 1
											ELSE 8
										END
									) - DATEPART(dw, @endMonth)
								), @endMonth -- date to add to
							);

	-- Compare start and end date and add a -1
		IF @activityDate BETWEEN @StartDate AND @endDate
		BEGIN
			SET @calculatedTimeZone = @calculatedTimeZone - 1;
		END;
	END;

	RETURN @calculatedTimeZone;
END;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO