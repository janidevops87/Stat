if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceLevelSecondaryCtls]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceLevelSecondaryCtls]
GO

CREATE TABLE [dbo].[ServiceLevelSecondaryCtls] (
	[ServiceLevelSecondaryCtlsID] [int] IDENTITY (1, 1) NOT NULL ,
	[ServiceLevelID] [int] NULL ,
	[ParentID] [int] NULL ,
	[ControlName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DisplayName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DisplayOrder] [int] NULL ,
	[Visible] [smallint] NULL ,
	[X] [int] NULL ,
	[Y] [int] NULL ,
	[Height] [int] NULL ,
	[LeftPos] [int] NULL ,
	[MaxChar] [int] NULL 
) ON [PRIMARY]
GO


