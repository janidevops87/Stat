if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaOrganization]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaOrganization]
GO

CREATE TABLE [dbo].[CriteriaOrganization] (
	[CriteriaOrganizationID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


