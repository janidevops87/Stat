if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationOrganization]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationOrganization]
GO

CREATE TABLE [dbo].[RotationOrganization] (
	[RotationGroupID] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[OrganizationName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationCity] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationState] [int] NULL ,
	[OrganizationType] [int] NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


