if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationCriteria]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationCriteria]
GO

CREATE TABLE [dbo].[RotationCriteria] (
	[RotationID] [int] NULL ,
	[RotationGroupID] [int] NULL ,
	[CriteriaID] [int] NULL ,
	[CriteriaType] [int] NULL ,
	[CriteriaGroupName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CriteriaGroupID] [int] NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


