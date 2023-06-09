if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSCase]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSCase]
GO

CREATE TABLE [dbo].[FSCase] (
	[FSCaseId] [int] NOT NULL ,
	[CallId] [int] NULL ,
	[FSCaseCreateUserId] [int] NULL ,
	[FSCaseCreateDateTime] [datetime] NULL ,
	[FSCaseOpenUserId] [int] NULL ,
	[FSCaseOpenDateTime] [datetime] NULL ,
	[FSCaseSysEventsUserId] [int] NULL ,
	[FSCaseSysEventsDateTime] [datetime] NULL ,
	[FSCaseSecCompUserId] [int] NULL ,
	[FSCaseSecCompDateTime] [datetime] NULL ,
	[FSCaseApproachUserId] [int] NULL ,
	[FSCaseApproachDateTime] [datetime] NULL ,
	[FSCaseFinalUserId] [int] NULL ,
	[FSCaseFinalDateTime] [datetime] NULL ,
	[FSCaseUpdate] [datetime] NULL ,
	[FSCaseUserId] [int] NULL ,
	[FSCaseBillSecondaryUserID] [int] NULL ,
	[FSCaseBillDateTime] [datetime] NULL ,
	[FSCaseBillApproachUserID] [int] NULL ,
	[FSCaseBillApproachDateTime] [datetime] NULL ,
	[FSCaseBillMedSocUserID] [int] NULL ,
	[FSCaseBillMedSocDateTime] [datetime] NULL ,
	[SecondaryManualBillPersonId] [int] NULL ,
	[SecondaryUpdatedFlag] [smallint] NULL ,
	[FSCaseTotalTime] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FSCaseSeconds] [int] NULL ,
	[FSCaseBillFamUnavailUserId] [int] NULL ,
	[FSCaseBillFamUnavailDateTime] [datetime] NULL ,
	[FSCaseBillCryoFormUserId] [int] NULL ,
	[FSCaseBillCryoFormDateTime] [datetime] NULL ,
	[FSCaseBillApproachCount] [smallint] NULL ,
	[FSCaseBillMedSocCount] [smallint] NULL ,
	[FSCaseBillCryoFormCount] [smallint] NULL ,
	[FSCaseBillOTEPerson] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FSCaseBillOTEUserID] [smallint] NULL ,
	[FSCaseBillOTEDateTime] [datetime] NULL ,
	[FSCaseBillOTECount] [smallint] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_107_13] ON [dbo].[FSCase] ([FSCaseFinalUserId]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_107_5] ON [dbo].[FSCase] ([FSCaseOpenUserId]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_107_2_13] ON [dbo].[FSCase] ([CallId], [FSCaseFinalUserId]) ')
GO

 CREATE    INDEX [PK_FSCase] ON [dbo].[FSCase]([FSCaseId]) WITH FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [callid] ON [dbo].[FSCase]([CallId]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [FSCase0] ON [dbo].[FSCase]([FSCaseFinalUserId], [CallId], [FSCaseOpenUserId]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [FSCaseUserID_CaseID] ON [dbo].[FSCase]([FSCaseCreateUserId], [FSCaseId]) WITH  FILLFACTOR = 90,  PAD_INDEX  ON [IDX]
GO


