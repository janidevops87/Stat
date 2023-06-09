if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Rotation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Rotation]
GO

CREATE TABLE [dbo].[Rotation] (
	[RotationID] [int] NULL ,
	[RotationName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RotationFrequency] [int] NULL ,
	[RotationSequence] [int] NULL ,
	[RotationLastRun] [datetime] NULL ,
	[RotationNextRun] [datetime] NULL ,
	[RotationReportAccessDate] [datetime] NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RotationGroupID] [int] NULL ,
	[ServiceLevelID] [int] NULL ,
	[ServiceLevelName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CurrentRotation] [smallint] NULL ,
	[RotationRemediate] [smallint] NULL 
) ON [PRIMARY]
GO


