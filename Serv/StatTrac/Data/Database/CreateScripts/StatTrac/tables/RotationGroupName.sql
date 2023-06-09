if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationGroupName]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationGroupName]
GO

CREATE TABLE [dbo].[RotationGroupName] (
	[RotationGroupName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[RotationGroupID] [int] IDENTITY (1, 1) NOT NULL ,
	[RotationID] [int] NULL ,
	[RotationFrequency] [int] NULL ,
	[RotationActive] [smallint] NULL ,
	[RotationTimeZone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


