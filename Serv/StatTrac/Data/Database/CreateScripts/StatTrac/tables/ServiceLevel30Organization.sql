if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceLevel30Organization]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceLevel30Organization]
GO

CREATE TABLE [dbo].[ServiceLevel30Organization] (
	[ServiceLevelOrganizationID] [int] IDENTITY (1, 1) NOT NULL ,
	[ServiceLevelID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


