IF NOT EXISTS (SELECT * FROM ReportDateType where ReportDateTypeName = 'Referral')
BEGIN
 	INSERT ReportDateType (ReportDateTypeName, ReportDateTypeDisplayName)
		VALUES('Referral', 'Referral')
END
IF NOT EXISTS (SELECT * FROM ReportDateType where ReportDateTypeName = 'Cardiac')
BEGIN
	INSERT ReportDateType (ReportDateTypeName, ReportDateTypeDisplayName)
		VALUES('Cardiac', 'Cardiac Death')
END