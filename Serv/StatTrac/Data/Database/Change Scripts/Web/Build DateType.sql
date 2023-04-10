 select '
IF NOT EXISTS (
		SELECT 	
			ReportDateTypeName,
			ReportDateTypeDisplayname 
		FROM 
			ReportDateTypeConfiguration  rstc 
		JOIN 
			ReportDateType rst ON rst.ReportDateTypeID = rstc.ReportDateTypeID
		WHERE 
			ReportID = @ReportID
		AND 
			ReportDateTypeName = ''' + ReportDateTypeName + '''
		AND
			ReportDateTypeDisplayname = ''' + ReportDateTypeDisplayname + '''
	 	)
BEGIN

	SELECT 
		@DateTypeID  = ReportDateTypeID 
	FROM 
		ReportDateType 
	WHERE 
		ReportDateTypeName = ''' + ReportDateTypeName + '''
	AND 
		ReportDateTypeDisplayname = ''' + ReportDateTypeDisplayname + '''

	exec spi_ReportDateTypeConfiguration
		@reportid,
		@DateTypeID	
	
END
	'


,* 


from ReportDateType 
WHERE ReportDateTypeID in (1,2 ) 