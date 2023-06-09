if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSAppropriate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSAppropriate]
GO

CREATE TABLE [dbo].[FSAppropriate] (
	[FSAppropriateID] [int] IDENTITY (1, 1) NOT NULL ,
	[FSAppropriateName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FSAppropriateReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[FSAppropriateReportDisplaySort1] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[AppropriateReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


