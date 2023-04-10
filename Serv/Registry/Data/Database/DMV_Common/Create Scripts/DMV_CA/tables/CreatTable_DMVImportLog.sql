/* CA DMVIMPORTLOG */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVIMPORTLOG]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	PRINT 'Dropping DMVIMPORTLOG Table'
	drop table [dbo].[DMVIMPORTLOG]
End
GO

	PRINT 'Creating DMVIMPORTLOG Table'
GO

CREATE TABLE [DMVIMPORTLOG] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RunStart] [datetime] NULL CONSTRAINT [DF_DMVIMPORTLOG_RunStart] DEFAULT (getdate()),
	[RunEnd] [datetime] NULL ,
	[RunStatus] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_DMVIMPORTLOG_RunStatus] DEFAULT ('LOADING'),
	[RunType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_DMVIMPORTLOG_RunType] DEFAULT ('Update'),
	[RecordsTotal] [int] NULL CONSTRAINT [DF_DMVIMPORTLOG_RecordsTotal] DEFAULT (0),
	[RecordsSuspended] [int] NULL CONSTRAINT [DF_DMVIMPORTLOG_RecordsSuspended] DEFAULT (0),
	[RecordsAdded] [int] NULL CONSTRAINT [DF_DMVIMPORTLOG_RecordsAdded] DEFAULT (0),
	[RecordsUpdated] [int] NULL CONSTRAINT [DF_DMVIMPORTLOG_RecordsUpdated] DEFAULT (0),
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	CONSTRAINT [PK_DMVIMPORTLOG] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
) ON [PRIMARY]
GO
