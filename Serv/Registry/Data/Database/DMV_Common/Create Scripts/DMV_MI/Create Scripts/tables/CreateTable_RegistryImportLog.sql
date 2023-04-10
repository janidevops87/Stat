/******************************************************************************
**		File: CreateTable_RegistryImportLog.sql
**		Name: RegistryImportLog
**		Desc: Create table: RegistryImportLog
**
**		Auth: ccarroll
**		Date: 12/10/2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      12/10/2010	ccarroll			initial
*******************************************************************************/
	PRINT 'Drop All Foreign Keys to RegistryImportLog'
	WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
					(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
						(SELECT Id FROM sysobjects WHERE name = 'RegistryImportLog')))
	BEGIN
		DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
			@FkTableName varchar(500), @KeyName varchar(500)

		SELECT @TableNameId = Id FROM sysobjects WHERE name = 'RegistryImportLog'
		SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
		SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
		SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
		
		SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
		EXEC(@sqlScript)
	END				


  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RegistryImportLog]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	PRINT 'Creating Table: RegistryImportLog'
	CREATE TABLE [dbo].[RegistryImportLog](
		[RegistryImportLogID] [int] IDENTITY(1,1) NOT NULL,
		[RunStart] [datetime] NULL,
		[RunEnd] [datetime] NULL,
		[RunStatus] [varchar](12) NULL,
		[RecordsTotal] [int] NULL,
		[RecordsSuspended] [int] NULL,
		[RecordsAdded] [int] NULL,
		[RecordsUpdated] [int] NULL,
		[LastModified] [datetime] NULL,
		[CreateDate] [datetime] NULL,
	 CONSTRAINT [PK_RegistryImportLog] PRIMARY KEY NONCLUSTERED 
	(
		[RegistryImportLogID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	SET ANSI_PADDING OFF
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RunStart]  DEFAULT (getdate()) FOR [RunStart]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RunStatus]  DEFAULT ('LOADING') FOR [RunStatus]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsTotal]  DEFAULT (0) FOR [RecordsTotal]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsSuspended]  DEFAULT (0) FOR [RecordsSuspended]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsAdded]  DEFAULT (0) FOR [RecordsAdded]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsUpdated]  DEFAULT (0) FOR [RecordsUpdated]

END

	GRANT SELECT ON RegistryImportLog TO PUBLIC
GO

/******************************************************************************
**		File: CreateTable_RegistryImportLog.sql
**		Name: RegistryImportLog
**		Desc: Create table: RegistryImportLog
**
**		Auth: ccarroll
**		Date: 12/10/2010 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      12/10/2010	ccarroll			initial
*******************************************************************************/
	PRINT 'Drop All Foreign Keys to RegistryImportLog'
	WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
					(SELECT MAX(constid) FROM sysforeignkeys WHERE rkeyid = 
						(SELECT Id FROM sysobjects WHERE name = 'RegistryImportLog')))
	BEGIN
		DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
			@FkTableName varchar(500), @KeyName varchar(500)

		SELECT @TableNameId = Id FROM sysobjects WHERE name = 'RegistryImportLog'
		SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE rkeyid = @TableNameId
		SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
		SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
		
		SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
		EXEC(@sqlScript)
	END				


  IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[RegistryImportLog]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	PRINT 'Creating Table: RegistryImportLog'
	CREATE TABLE [dbo].[RegistryImportLog](
		[RegistryImportLogID] [int] IDENTITY(1,1) NOT NULL,
		[RunStart] [datetime] NULL,
		[RunEnd] [datetime] NULL,
		[RunStatus] [varchar](12) NULL,
		[RecordsTotal] [int] NULL,
		[RecordsSuspended] [int] NULL,
		[RecordsAdded] [int] NULL,
		[RecordsUpdated] [int] NULL,
		[LastModified] [datetime] NULL,
		[CreateDate] [datetime] NULL,
	 CONSTRAINT [PK_RegistryImportLog] PRIMARY KEY NONCLUSTERED 
	(
		[RegistryImportLogID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	SET ANSI_PADDING OFF
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RunStart]  DEFAULT (getdate()) FOR [RunStart]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RunStatus]  DEFAULT ('LOADING') FOR [RunStatus]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsTotal]  DEFAULT (0) FOR [RecordsTotal]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsSuspended]  DEFAULT (0) FOR [RecordsSuspended]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsAdded]  DEFAULT (0) FOR [RecordsAdded]
	ALTER TABLE [dbo].[RegistryImportLog] ADD  CONSTRAINT [DF_RegistryImportLog_RecordsUpdated]  DEFAULT (0) FOR [RecordsUpdated]

END

	GRANT SELECT ON RegistryImportLog TO PUBLIC
GO

