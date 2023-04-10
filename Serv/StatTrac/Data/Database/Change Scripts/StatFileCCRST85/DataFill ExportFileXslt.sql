 if ((select count(*) from ExportFilexslt) = 0)
 BEGIN
	 PRINT 'insert ExportFilexslt'

	insert ExportFilexslt
	select 'StatFile'+REPLACE(ExportFileTypeName, ' ', '')+'.xslt' from ExportFileType

 END