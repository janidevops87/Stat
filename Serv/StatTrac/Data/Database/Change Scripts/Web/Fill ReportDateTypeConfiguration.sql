UPDATE ReportDateTypeConfiguration
SET ReportDateTypeConfigurationIsDefault = 0
DECLARE
	@ReportID	INT,
	@ReportDateTypeID INT 

SELECT
	@ReportID = ReportID FROM REPORT WHERE ReportDisplayName = 'Referral Detail'
	SELECT
		@ReportDateTypeID	= ReportDateTypeID 
	FROM 
		ReportDateType
	WHERE
		ReportDateTypeName = 'Referral'

	UPDATE 
		ReportDateTypeConfiguration
	SET 
		ReportDateTypeConfigurationIsDefault = 1
	WHERE
		ReportID = @ReportID
	AND
		ReportDateTypeID = @ReportDateTypeID

SELECT
	@ReportID	 = ReportID  FROM REPORT WHERE ReportDisplayName = 'Conversion Rate'
IF NOT EXISTS (SELECT * FROM ReportDateTypeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTypeID = 1
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
	 @ReportDateTypeID 
END	
SELECT
	@ReportID	 = ReportID  FROM REPORT WHERE ReportDisplayName = 'Conversion Rate (Archive)'
IF NOT EXISTS (SELECT * FROM ReportDateTypeConfiguration WHERE ReportID = @ReportID)
BEGIN

	SET
		@ReportDateTypeID = 1
	exec spi_ReportDateTypeConfiguration
		@ReportID	,
	 @ReportDateTypeID 
END	
SELECT 
	*
FROM
	ReportDateTypeConfiguration