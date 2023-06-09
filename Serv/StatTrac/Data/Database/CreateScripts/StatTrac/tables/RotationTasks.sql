if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationTasks]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationTasks]
GO

CREATE TABLE [dbo].[RotationTasks] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RotationGroupID] [int] NULL ,
	[RotationID] [int] NULL ,
	[Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TypeID] [int] NULL ,
	[TypeName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[OrganizationName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StoredProc] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


