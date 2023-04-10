DECLARE
	@ReportID	INT,
	@ReportDateTimeID INT 

SELECT
	@ReportID	 = ReportID FROM REPORT WHERE ReportDisplayName = 'Processor Number'
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN
	SET
		@ReportDateTimeID	= 1
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID
END


SELECT
	@ReportID	 = ReportID FROM REPORT WHERE ReportDisplayName = 'Approach Person Outcome'
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN
	SET
		@ReportDateTimeID	= 1
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID
END	

SELECT
	@ReportID	 = ReportID FROM REPORT WHERE ReportDisplayName = 'Referral Detail' and reportid > 72
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTimeID	= 2
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID
END	

SELECT
	@ReportID	 = ReportID  FROM REPORT WHERE ReportDisplayName = 'Conversion Rate'
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTimeID	= 1
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID
END	
SELECT
	@ReportID	 = ReportID  FROM REPORT WHERE ReportDisplayName = 'Conversion Rate (Archive)'
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTimeID	= 1
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID
END	

SELECT
	@ReportID	 = ReportID  FROM REPORT WHERE ReportDisplayName = 'Total Call Time'
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTimeID	= 3
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
END
SELECT
	@ReportID	 = ReportID  FROM REPORT WHERE ReportDisplayName = 'FS Hourly'
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTimeID	= 2
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
END

SELECT
	@ReportID	 = ReportID  FROM REPORT WHERE ReportDisplayName = 'Avaya Call Detail Report'
IF NOT EXISTS (SELECT * FROM ReportDateTimeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTimeID	= 2
	EXEC spi_ReportDateTimeConfiguration
		@ReportID,
		@ReportDateTimeID	
END	
-- SELECT * FROM ReportDateTime
-- SELECT * FROM ReportDateType
-- SELECT * FROM ReportControl
-- SELECT ReportID FROM REPORT WHERE ReportDisplayName = 'Approach Person Outcome'
-- SELECT * FROM ReportDateTimeConfiguration
/*
	ReportDateTimeID ReportDateTimeName                                 
	---------------- -------------------------------------------------- 
	1                Monthly                                            
	2                Yesterday                                          
	3                Today                                              
	4                Now  

delete ReportDateTimeConfiguration
where reportid = 200

*/