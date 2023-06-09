if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveCODCaller]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveCODCaller]
GO

CREATE TABLE [dbo].[ArchiveCODCaller] (
	[CODCallerID] [int] NOT NULL ,
	[CallID] [int] NULL ,
	[CODCallerFirst] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODCallerLast] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODCallerAddress1] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODCallerAddress2] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODCallerCity] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StateID] [int] NULL ,
	[CODCallerZip] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[CODCallerPhone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODCallerLabelStatus] [int] NOT NULL ,
	[CODCallPassToCoalition] [int] NULL ,
	[CODAdMethod] [int] NULL ,
	[CODQuestions] [int] NULL ,
	[CODCallerVM] [smallint] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


