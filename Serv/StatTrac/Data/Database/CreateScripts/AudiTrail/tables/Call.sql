if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Call]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Call]
GO

CREATE TABLE [dbo].[Call] (
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
	[CallSaveLastByID] [int] NULL ,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [CallTypeID] ON [dbo].[Call] ([CallTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [CallSeconds] ON [dbo].[Call] ([CallSeconds]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_1_12] ON [dbo].[Call] ([CallID], [SourceCodeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_2_12] ON [dbo].[Call] ([CallNumber], [SourceCodeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_12_2] ON [dbo].[Call] ([SourceCodeID], [CallNumber]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_2_1] ON [dbo].[Call] ([CallNumber], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_12_1] ON [dbo].[Call] ([SourceCodeID], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_1_2] ON [dbo].[Call] ([CallID], [CallNumber]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_1_2_12] ON [dbo].[Call] ([CallID], [CallNumber], [SourceCodeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_2_1_12] ON [dbo].[Call] ([CallNumber], [CallID], [SourceCodeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_12_1_2] ON [dbo].[Call] ([SourceCodeID], [CallID], [CallNumber]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_127_4_1_2_3_5_6_7_8_9_10_11] ON [dbo].[Call] ([CallDateTime], [CallID], [CallNumber], [CallTypeID], [StatEmployeeID], [CallTotalTime], [CallTempExclusive], [Inactive], [CallSeconds], [LastModified], [CallTemp]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_157_1_2] ON [dbo].[Call] ([CallID], [CallNumber]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_157_2_1] ON [dbo].[Call] ([CallNumber], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_157_1_12] ON [dbo].[Call] ([CallID], [SourceCodeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_157_2_12] ON [dbo].[Call] ([CallNumber], [SourceCodeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_157_12_2] ON [dbo].[Call] ([SourceCodeID], [CallNumber]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_157_12_1] ON [dbo].[Call] ([SourceCodeID], [CallID]) ')
GO

 CREATE  INDEX [CallDateTime] ON [dbo].[Call]([CallDateTime]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [CallNumber] ON [dbo].[Call]([CallNumber]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [CallTemp] ON [dbo].[Call]([CallTemp]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [CallTempSavedByID] ON [dbo].[Call]([CallTempSavedByID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

CREATE INDEX PK_Call_1__13 ON dbo.Call
	(
	CallID
	) WITH FILLFACTOR = 90 ON [IDX]
GO

