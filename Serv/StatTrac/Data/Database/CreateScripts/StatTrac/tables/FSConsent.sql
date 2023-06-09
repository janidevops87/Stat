if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSConsent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSConsent]
GO

CREATE TABLE [dbo].[FSConsent] (
	[FSConsentID] [int] NOT NULL ,
	[FSConsentName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FSConsentReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[FSConsentReportDisplaySort1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[FSConsentReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


