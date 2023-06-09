if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceLevelCustomList]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceLevelCustomList]
GO

CREATE TABLE [dbo].[ServiceLevelCustomList] (
	[ServiceLevelID] [int] NOT NULL ,
	[ServiceLevelListField] [smallint] NULL ,
	[ServiceLevelListItem] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomListID] [int] IDENTITY (1, 1) NOT NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO


