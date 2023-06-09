if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Conversion]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Conversion]
GO

CREATE TABLE [dbo].[Conversion] (
	[ConversionID] [int] IDENTITY (1, 1) NOT NULL ,
	[ConversionName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ConversionReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[ConversionReportDisplaySort1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[ConversionReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


