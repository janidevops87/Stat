IF EXISTS (SELECT * FROM sysobjects WHERE xtype = 'FN' AND name = 'fn_rpt_ConvertSecondsToTime')
	BEGIN
		PRINT 'Dropping Function fn_rpt_ConvertSecondsToTime'
		DROP  Function  fn_rpt_ConvertSecondsToTime
	END

GO

PRINT 'Creating Function fn_rpt_ConvertSecondsToTime'
GO

/******************************************************************************
**	Name: fn_rpt_ConvertSecondsToTime
**	Desc: Given the number of seconds, returns it in a time format hh:mm
**			with options to include days and/or seconds dd:hh:mm:ss
**
**	Author: James Gerberich
**	Date:	6/14/2018
*******************************************************************************/

CREATE FUNCTION dbo.fn_rpt_ConvertSecondsToTime (@Seconds bigint, @ShowDays bit, @ShowSeconds bit)
RETURNS	varchar(100)
AS
BEGIN

DECLARE
	@Sign			varchar(3) = '',
	@Days			int,
	@Hours			int,
	@Minutes		int,
	@DateString		varchar(4000),
	@DayString		varchar(4000),
	@HourString		varchar(4000),
	@MinuteString	char(3),
	@SecondString	char(3);

IF (@Seconds < 0)
	SET @Sign = '-';

SELECT
	@Days = ABS(@Seconds / 86400),
	@Hours = ABS((@seconds % 86400) / 3600),
	@Minutes = ABS((@seconds % 3600) / 60),
	@Seconds = ABS(@Seconds % 60);

IF(@ShowDays = 1)
	IF(@Hours < 10)
		BEGIN
			SET @DayString = CAST(@Days AS varchar(4000))
			SET @HourString = ':0' + CAST(@Hours AS char(1))
		END
	ELSE
		BEGIN
			SET @DayString = CAST(@Days AS varchar(4000))
			SET @HourString = ':' + CAST(@Hours AS char(2))
		END
ELSE
	BEGIN
		SET @DayString = ''
		SET @Hours = (@Days * 24) + @Hours
		SET @HourString = CAST(@Hours AS varchar(4000))
	END;

IF(@Minutes < 10)
	BEGIN
		SET @MinuteString = ':0' + CAST(@Minutes AS char(1))
	END
ELSE
	BEGIN
		SET @MinuteString = ':' + CAST(@Minutes AS char(2))
	END;

IF (@ShowSeconds = 1)
	IF(@Seconds < 10)
		BEGIN
			SET @SecondString = ':0' + CAST(@seconds AS char(1))
		END
	ELSE
		BEGIN
			SET @SecondString = ':' + CAST(@seconds AS char(2))
		END
ELSE
	SET @SecondString = '';


SELECT @DateString = @Sign + @DayString + @HourString + @MinuteString + @SecondString;

RETURN @DateString;

END