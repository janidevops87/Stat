if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ReportType]
GO

CREATE TABLE [dbo].[ReportType] (
	[REPORTTYPEID] [int] IDENTITY (8, 1) NOT NULL ,
	[REPORTTYPENAME] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


