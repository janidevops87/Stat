if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSConversion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSConversion]
GO

CREATE TABLE [dbo].[FSConversion] (
	[FSConversionID] [int] NOT NULL ,
	[FSConversionName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FSConversionReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[FSConversionReportDisplaySort1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[FSConversionReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


