if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DesignatedRequestors_ORG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DesignatedRequestors_ORG]
GO

CREATE TABLE [dbo].[DesignatedRequestors_ORG] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ORG] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[OrganizationName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


