if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ReportLog]
GO

CREATE TABLE [dbo].[ReportLog] (
	[ReportLogID] [int] IDENTITY (1, 1) NOT NULL ,
	[ReportLogDateTime] [datetime] NULL ,
	[ReportID] [int] NULL ,
	[WebPersonID] [int] NULL ,
	[ReportLogRemoteAddress] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReportLogQueryString] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


