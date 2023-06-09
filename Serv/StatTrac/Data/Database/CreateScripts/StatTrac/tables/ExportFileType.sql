PRINT ' TABLE [ExportFileType] '
if NOT exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ExportFileType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

	CREATE TABLE [dbo].[ExportFileType] (
		[ExportFileTypeID] [smallint] IDENTITY (1, 1) NOT NULL ,
		[ExportFileTypeName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[LastModified] [smalldatetime] NULL ,
		[UpdatedFlag] [smallint] NULL 
	) ON [PRIMARY]
	
	
END

IF NOT EXISTS(
			SELECT     syscolumns.name AS columName
            FROM       sysobjects INNER JOIN
                       syscolumns ON syscolumns.id = sysobjects.id
            WHERE	(sysobjects.id = OBJECT_ID(N'[dbo].[ExportFileType]')) 
            AND		(OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1) 
            AND		(syscolumns.name IN (N'ExportFileXsltID', 'Enabled', 'ExportFileDataTypeID'  ))
)
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

	ALTER TABLE dbo.ExportFileType ADD
		ExportFileXsltID int NULL,
		Enabled bit NULL,
		ExportFileDataTypeID int NULL

	ALTER TABLE dbo.ExportFileType ADD CONSTRAINT
		DF_ExportFileType_Enabled DEFAULT 1 FOR Enabled

	COMMIT
END

