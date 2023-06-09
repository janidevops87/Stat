if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Appropriate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Appropriate]
GO

CREATE TABLE [dbo].[Appropriate] (
	[AppropriateID] [int] IDENTITY (1, 1) NOT NULL ,
	[AppropriateName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AppropriateReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[AppropriateReportDisplaySort1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[AppropriateReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


