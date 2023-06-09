if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Consent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Consent]
GO

CREATE TABLE [dbo].[Consent] (
	[ConsentID] [int] IDENTITY (1, 1) NOT NULL ,
	[ConsentName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ConsentReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[ConsentReportDisplaySort1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[ConsentReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


