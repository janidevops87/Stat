if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SubLocationLevel]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SubLocationLevel]
GO

CREATE TABLE [dbo].[SubLocationLevel] (
	[SubLocationLevelID] [int] IDENTITY (1, 1) NOT NULL ,
	[SubLocationLevelName] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


