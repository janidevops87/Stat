if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationAlerts]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationAlerts]
GO

CREATE TABLE [dbo].[RotationAlerts] (
	[Rotationid] [int] NULL ,
	[RotationGroupID] [int] NULL ,
	[AlertID] [int] NULL ,
	[AlertType] [int] NULL ,
	[AlertGroupName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[id] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


