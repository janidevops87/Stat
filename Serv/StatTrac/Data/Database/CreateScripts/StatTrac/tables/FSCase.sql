if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSCase]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSCase]
GO

CREATE TABLE [dbo].[FSCase] (
	[FSCaseId] [int] IDENTITY (1, 1) NOT NULL ,
	[CallId] [int] NOT NULL ,
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
	[FSCaseBillOTECount] [smallint] NULL 
) ON [PRIMARY]
GO


