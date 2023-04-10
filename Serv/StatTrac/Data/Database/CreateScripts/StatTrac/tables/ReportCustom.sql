if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportCustom]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ReportCustom]
GO

CREATE TABLE [dbo].[ReportCustom] (
	[ReportCustomID] [int] IDENTITY (1, 1) NOT NULL ,
	[ReportCustomReportID] [int] NULL ,
	[ReportCustomOrganizationID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UserID] [int] NULL 
) ON [PRIMARY]
GO


