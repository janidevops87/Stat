if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationScheduleGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationScheduleGroup]
GO

CREATE TABLE [dbo].[RotationScheduleGroup] (
	[RotationID] [int] NULL ,
	[RotationGroupID] [int] NULL ,
	[RotationScheduleGroupName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RotationScheduleGroupID] [int] NULL ,
	[RotationScheduleGroupType] [int] NULL ,
	[RotationScheduleGroupTypeName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


