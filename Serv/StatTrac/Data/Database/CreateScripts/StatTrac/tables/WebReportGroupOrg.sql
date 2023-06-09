if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebReportGroupOrg]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WebReportGroupOrg]
GO

CREATE TABLE [dbo].[WebReportGroupOrg] (
	[WebReportGroupOrgID] [int] IDENTITY (1, 1) NOT NULL ,
	[ReportID] [int] NULL ,
	[WebReportGroupID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[PersonID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


