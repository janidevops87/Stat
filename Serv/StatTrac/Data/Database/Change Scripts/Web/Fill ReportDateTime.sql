DECLARE
	@ReportDateTimeName VARCHAR(50) 

IF NOT EXISTS (SELECT * FROM ReportDateTime where ReportDateTimeName = 'Monthly')
BEGIN
	SELECT @ReportDateTimeName = 'Monthly'
	EXEC spi_ReportDateTime @ReportDateTimeName 
END

IF NOT EXISTS (SELECT * FROM ReportDateTime where ReportDateTimeName = 'Yesterday')
BEGIN

	SELECT @ReportDateTimeName = 'Yesterday'
	EXEC spi_ReportDateTime @ReportDateTimeName 
END

IF NOT EXISTS (SELECT * FROM ReportDateTime where ReportDateTimeName = 'Today')
BEGIN

	SELECT @ReportDateTimeName = 'Today'
	EXEC spi_ReportDateTime @ReportDateTimeName 
END

IF NOT EXISTS (SELECT * FROM ReportDateTime where ReportDateTimeName = 'Now')
BEGIN

	SELECT @ReportDateTimeName = 'Now'
	EXEC spi_ReportDateTime @ReportDateTimeName 
END
