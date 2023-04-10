if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationRunArchive]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationRunArchive]
GO

CREATE TABLE [dbo].[RotationRunArchive] (
	[RotationGroupID] [int] NULL ,
	[RotationID] [int] NULL ,
	[RotationGroupName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RotationName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


