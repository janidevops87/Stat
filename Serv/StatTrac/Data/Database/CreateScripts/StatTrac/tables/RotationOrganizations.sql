if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationOrganizations]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationOrganizations]
GO

CREATE TABLE [dbo].[RotationOrganizations] (
	[RotationID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[OrganizationName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


