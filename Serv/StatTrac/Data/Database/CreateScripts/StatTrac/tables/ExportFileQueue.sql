PRINT 'Table ExportFileQueue'
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ExportFileQueue')
	BEGIN
		CREATE TABLE ExportFileQueue
		(
			ExportFileQueueID INT IDENTITY(1,1),
			CallID INT,
			ExportFileID INT,
			Enabled BIT

		)

		GRANT SELECT ON ExportFileQueue TO PUBLIC

		

	END

