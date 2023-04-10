if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportGroupList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ReportGroupList]
GO

CREATE TABLE [dbo].[ReportGroupList] (
	[ReportGroupListID] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ReportGroupListName] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


