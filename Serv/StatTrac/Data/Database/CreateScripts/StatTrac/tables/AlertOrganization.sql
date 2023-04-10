if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AlertOrganization]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AlertOrganization]
GO

CREATE TABLE [dbo].[AlertOrganization] (
	[AlertOrganizationID] [int] IDENTITY (1, 1) NOT NULL ,
	[AlertID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


