if not exists(
				SELECT * FROM SYSCOLUMNS SC
				JOIN SYSOBJECTS SO ON SO.ID = SC.ID
				WHERE 
				SO.NAME LIKE 'ReportDateTimeConfiguration'
				and
				SC.NAME LIKE 'IsArchived' or SC.name like 'IsDateOnly'
			)
BEGIN
	PRINT N'Altering [dbo].[ReportDateTimeConfiguration]'

	ALTER TABLE [dbo].[ReportDateTimeConfiguration] ADD
	[IsArchived] [bit] NOT NULL CONSTRAINT [DF_ReportDateTimeConfiguration_IsArchived] DEFAULT (0),
	[IsDateOnly] [bit] NOT NULL CONSTRAINT [DF_ReportDateTimeConfiguration_IsDateOnly] DEFAULT (0)

	IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION

END