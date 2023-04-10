if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[HistoryStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[HistoryStatus]
GO

CREATE TABLE [dbo].[HistoryStatus] (
	[HistoryStatusId] [int] NOT NULL ,
	[HistoryStatusName] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HistoryStatusDescription] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


