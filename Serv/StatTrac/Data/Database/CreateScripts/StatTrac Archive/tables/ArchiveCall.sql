if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveCall]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveCall]
GO

CREATE TABLE [dbo].[ArchiveCall] (
	[CallID] [int] NOT NULL ,
	[CallNumber] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallTypeID] [int] NULL ,
	[CallDateTime] [smalldatetime] NULL ,
	[StatEmployeeID] [smallint] NULL ,
	[CallTotalTime] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallTempExclusive] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[CallSeconds] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[CallTemp] [smallint] NULL ,
	[SourceCodeID] [int] NULL ,
	[CallOpenByID] [int] NULL ,
	[CallTempSavedByID] [int] NULL ,
	[CallExtension] [numeric](5, 0) NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[CallOpenByWebPersonId] [int] NULL ,
	[RecycleNCFlag] [smallint] NULL ,
	[CallActive] [smallint] NULL ,
	[CallSaveLastByID] [int] NULL,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO


