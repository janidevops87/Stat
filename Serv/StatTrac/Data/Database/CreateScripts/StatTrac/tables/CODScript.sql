if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CODScript]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CODScript]
GO

CREATE TABLE [dbo].[CODScript] (
	[CODScriptID] [int] IDENTITY (1, 1) NOT NULL ,
	[CODScriptTab] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODScriptArea] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODScriptCODGEN] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODScriptCODAA] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODScriptCODSPAN] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODScriptFieldName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODScriptArrayIndex] [int] NULL ,
	[CODScriptType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


