if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Report]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Report]
GO

CREATE TABLE [dbo].[Report] (
	[ReportID] [int] IDENTITY (1, 1) NOT NULL ,
	[ReportDisplayName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[ReportLocalOnly] [int] NULL ,
	[ReportVirtualURL] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReportTypeID] [smallint] NULL ,
	[Unused] [varbinary] (50) NULL ,
	[ReportDescFileName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[ReportSortOrderID] [smallint] NULL ,
	[ReportInDevelopment] [smallint] NULL ,
	[ReportFromDate] [smallint] NULL ,
	[ReportToDate] [smallint] NULL ,
	[ReportGroup] [smallint] NULL ,
	[ReportOrganization] [smallint] NULL 
) ON [PRIMARY]
GO


