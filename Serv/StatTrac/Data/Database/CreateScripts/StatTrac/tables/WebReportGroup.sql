if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebReportGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WebReportGroup]
GO

CREATE TABLE [dbo].[WebReportGroup] (
	[WebReportGroupID] [int] IDENTITY (1, 1) NOT NULL ,
	[WebReportGroupName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrgHierarchyParentID] [int] NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[WebReportGroupMaster] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[BatchFlag] [smallint] NULL 
) ON [PRIMARY]
GO


