 -- =============================================
-- Create scalar function (fn_AgeRange)
-- =============================================
IF EXISTS (SELECT * 
	   FROM   sysobjects 
	   WHERE  name = N'fn_AgeRange')
	DROP FUNCTION fn_AgeRange
GO

CREATE FUNCTION fn_AgeRange
	(
		@Age varchar(4), 
		@AgeUnit varchar(10)
	)
RETURNS int
AS
BEGIN
	DECLARE @AgeRangeID INT

	SELECT 
		@AgeRangeID = AgeRangeID
	FROM 
		_ReferralProd_DataWarehouse..AgeRange
	WHERE
		(
		(cast(@Age as Int) BETWEEN AgeRangeStart AND AgeRangeEnd 
	AND 
		@AgeUnit = 'Years')

	OR 
		
		((@Age / 365) BETWEEN AgeRangeStart AND AgeRangeEnd
	AND 
		@AgeUnit = 'Days')
	OR 
		((@Age / 12) BETWEEN AgeRangeStart AND AgeRangeEnd
	 AND 
		@AgeUnit = 'Months')
		)
	RETURN @AgeRangeID
END
GO