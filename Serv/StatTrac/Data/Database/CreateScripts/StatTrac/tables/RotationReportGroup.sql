if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationReportGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationReportGroup]
GO

CREATE TABLE [dbo].[RotationReportGroup] (
	[RotationID] [int] NULL ,
	[RotationGroupID] [int] NULL ,
	[RotationReportGroupName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RotationReportGroupID] [int] NULL ,
	[RotationReportGroupType] [int] NULL ,
	[RotationReportGroupTypeName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RotationAddAccessDate] [smallint] NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


