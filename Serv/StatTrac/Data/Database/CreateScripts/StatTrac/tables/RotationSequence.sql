if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationSequence]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationSequence]
GO

CREATE TABLE [dbo].[RotationSequence] (
	[RotationGroupID] [int] NULL ,
	[RotationID] [int] NULL ,
	[RotationName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Sequence] [int] NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[CurrentRotation] [smallint] NULL ,
	[NextRotation] [smallint] NULL 
) ON [PRIMARY]
GO


