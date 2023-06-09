PRINT 'TABLE ExportFile'
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ExportFile]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN

	CREATE TABLE [dbo].[ExportFile] (
		[ExportFileID] [int] IDENTITY (1, 1) NOT NULL ,
		[OrganizationID] [int] NULL ,
		[WebReportGroupID] [int] NULL ,
		[ExportFileDirectoryPath] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[ExportFileRecurringDateType] [int] NULL ,
		[ExportFileLastRefresh] [smalldatetime] NULL ,
		[ExportFileOn] [tinyint] NULL ,
		[ExportFileTypeID] [smallint] NULL ,
		[LastModified] [smalldatetime] NULL ,
		[ExportFileFromDate] [smalldatetime] NULL ,
		[ExportFileToDate] [smalldatetime] NULL ,
		[ExportFileName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[ExportFileFrequency] [smallint] NULL ,
		[ExportFileDateType] [smallint] NULL ,
		[ExportFileOccursAt] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[ExportFileFileDateType] [smallint] NULL ,
		[ExportFileSeparateFiles] [smallint] NULL ,
		[ExportFileTZ] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
		[UpdatedFlag] [smallint] NULL 
	) ON [PRIMARY]
END

if not exists (SELECT     sysobjects.name, sysobjects.id, sysobjects.xtype, sysobjects.uid, sysobjects.info, sysobjects.status, sysobjects.base_schema_ver, 
                                     sysobjects.replinfo, sysobjects.parent_obj, sysobjects.crdate, sysobjects.ftcatid, sysobjects.schema_ver, sysobjects.stats_schema_ver, 
                                     sysobjects.type, sysobjects.userstat, sysobjects.sysstat, sysobjects.indexdel, sysobjects.refdate, sysobjects.version, sysobjects.deltrig, 
                                     sysobjects.instrig, sysobjects.updtrig, sysobjects.seltrig, sysobjects.category, sysobjects.cache, syscolumns.name AS columName
               FROM         sysobjects INNER JOIN
                                     syscolumns ON syscolumns.id = sysobjects.id
               WHERE     (sysobjects.id = OBJECT_ID(N'[dbo].[ExportFile]')) AND (OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1) AND 
                                     (syscolumns.name IN (N'CloseCaseTriggerID', 'CloseCaseOverride', 'ExportFileFrequencyQuantity'  )))
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

	ALTER TABLE dbo.ExportFile ADD
		CloseCaseTriggerID int NULL,
		CloseCaseOverride int NULL,
		ExportFileFrequencyQuantity int NULL


	COMMIT
END
if not exists (SELECT     sysobjects.name, sysobjects.id, sysobjects.xtype, sysobjects.uid, sysobjects.info, sysobjects.status, sysobjects.base_schema_ver, 
                                     sysobjects.replinfo, sysobjects.parent_obj, sysobjects.crdate, sysobjects.ftcatid, sysobjects.schema_ver, sysobjects.stats_schema_ver, 
                                     sysobjects.type, sysobjects.userstat, sysobjects.sysstat, sysobjects.indexdel, sysobjects.refdate, sysobjects.version, sysobjects.deltrig, 
                                     sysobjects.instrig, sysobjects.updtrig, sysobjects.seltrig, sysobjects.category, sysobjects.cache, syscolumns.name AS columName
               FROM         sysobjects INNER JOIN
                                     syscolumns ON syscolumns.id = sysobjects.id
               WHERE     (sysobjects.id = OBJECT_ID(N'[dbo].[ExportFile]')) AND (OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1) AND 
                                     (syscolumns.name IN (N'LastStatEmployeeID', 'AuditLogTypeID')))
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

	ALTER TABLE dbo.ExportFile ADD
		LastStatEmployeeID int NULL,
		AuditLogTypeID int NULL


	COMMIT
END

IF NOT EXISTS(
			SELECT     syscolumns.name AS columName, st.*
            FROM       sysobjects INNER JOIN
                       syscolumns ON syscolumns.id = sysobjects.id
			JOIN	systypes st on st.xtype = syscolumns.xtype
            WHERE	(sysobjects.id = OBJECT_ID(N'[dbo].[ExportFile]')) 
            AND		(OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1) 
            AND		(syscolumns.name IN (N'ExportFileTypeID') )
			AND		(st.name = 'int')
            )

BEGIN
	ALTER TABLE dbo.ExportFile
		DROP CONSTRAINT FK_ExportFile_Organization
	ALTER TABLE dbo.ExportFile
		DROP CONSTRAINT FK_ExportFile_AuditLogType
	ALTER TABLE dbo.ExportFile
		DROP CONSTRAINT FK_ExportFile_StatEmployee
	ALTER TABLE dbo.ExportFile
		DROP CONSTRAINT FK_ExportFile_CloseCaseTrigger
	ALTER TABLE dbo.ExportFile
		DROP CONSTRAINT DF_ExportFile_CloseCaseTriggerID
	ALTER TABLE dbo.ExportFile
		DROP CONSTRAINT DF_ExportFile_CloseCaseOverride
	ALTER TABLE dbo.ExportFile
		DROP CONSTRAINT DF_ExportFile_ExportFileFrequencyQuantity
	ALTER TABLE dbo.ExportFile
		ALTER COLUMN ExportFileTypeID int NULL

END
