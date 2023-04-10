PRINT 'TABLE ExportFileXslt'
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ExportFileXslt')
	BEGIN
		CREATE TABLE ExportFileXslt
		(
		   ExportFileXsltID INT IDENTITY(1,1),
		   ExportFileXsltName NVARCHAR(100)

		)

		GRANT SELECT ON ExportFileXslt TO PUBLIC



	END

