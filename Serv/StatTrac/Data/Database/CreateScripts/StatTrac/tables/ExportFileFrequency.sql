PRINT ' Table ExportFileFrequency'
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'ExportFileFrequency')
	BEGIN
		/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
		BEGIN TRANSACTION
		SET QUOTED_IDENTIFIER ON
		SET ARITHABORT ON
		SET NUMERIC_ROUNDABORT OFF
		SET CONCAT_NULL_YIELDS_NULL ON
		SET ANSI_NULLS ON
		SET ANSI_PADDING ON
		SET ANSI_WARNINGS ON
		COMMIT
		BEGIN TRANSACTION

		CREATE TABLE dbo.ExportFileFrequency
		(
		    ExportFileFrequencyID int NOT NULL IDENTITY (1, 1),
			ExportFileFrequencyName nvarchar(50) NULL
		)  ON [PRIMARY]
		COMMIT	
		GRANT SELECT ON ExportFileFrequency TO PUBLIC


	END

