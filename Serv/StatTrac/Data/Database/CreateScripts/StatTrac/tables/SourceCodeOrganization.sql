if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SourceCodeOrganization]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SourceCodeOrganization]
GO

CREATE TABLE [dbo].[SourceCodeOrganization] (
	[SourceCodeOrganizationID] [int] IDENTITY (1, 1) NOT NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


