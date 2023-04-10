if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FS_CauseOfDeath]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FS_CauseOfDeath]
GO

CREATE TABLE [dbo].[FS_CauseOfDeath] (
	[FS_CauseOfDeathId] [int] IDENTITY (1, 1) NOT NULL ,
	[FS_CauseOfDeathName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


