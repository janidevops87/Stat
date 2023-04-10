IF EXISTS (SELECT * FROM sysobjects WHERE xtype = 'FN' AND name = 'fn_ConvertDateToDayOfWeek')
	BEGIN
		PRINT 'Dropping Function fn_ConvertDateToDayOfWeek'
		DROP  Function  fn_ConvertDateToDayOfWeek
	END

GO

PRINT 'Creating Function fn_ConvertDateToDayOfWeek'
GO

CREATE FUNCTION dbo.fn_ConvertDateToDayOfWeek
    (@convertdate SMALLDATETIME)
		RETURNS varchar(10) 
AS

BEGIN
	DECLARE @day INT
	DECLARE @Weekdate varchar(10)

	SET @day = DATEPART(dw, @convertdate)
	SET @Weekdate = 
			CASE	WHEN @day = 1 THEN 'Sunday'
					WHEN @day = 2 THEN 'Monday'
					WHEN @day = 3 THEN 'Tuesday'
					WHEN @day = 4 THEN 'Wednesday'
					WHEN @day = 5 THEN 'Thursday'
					WHEN @day = 6 THEN 'Friday'
					WHEN @day = 7 THEN 'Saturday'
			END

    RETURN @Weekdate
END
GO
 