 select '
IF NOT EXISTS (
		SELECT 	
			ReportSortTypeName,
			ReportSortTypeDisplayname 
		FROM 
			ReportSortTypeConfiguration  rstc 
		JOIN 
			ReportSortType rst ON rst.ReportSortTypeID = rstc.ReportSortTypeID
		WHERE 
			ReportID = @ReportID
		AND 
			ReportSortTypeName = ''' + ReportSortTypeName + '''
		AND
			ReportSortTypeDisplayname = ''' + ReportSortTypeDisplayname + '''
	 	)
BEGIN

	SELECT 
		@sortTypeID  = ReportSortTypeID 
	FROM 
		ReportSortType 
	WHERE 
		ReportSortTypeName = ''' + ReportSortTypeName + '''
	AND 
		ReportSortTypeDisplayname = ''' +  ReportSortTypeDisplayname + '''

	exec spi_ReportSortTypeConfiguration
		@reportid,
		@sortTypeID	
	
END
	'


--,* 


from ReportSortType 
WHERE ReportSortTypeID in (9, 16, 17, 10, 5, 14, 28, 29 )