if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ReportGroupListDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ReportGroupListDetail]
GO

CREATE TABLE [dbo].[ReportGroupListDetail] (
	[ReportGroupListDetailID] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ReportGroupListID] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


