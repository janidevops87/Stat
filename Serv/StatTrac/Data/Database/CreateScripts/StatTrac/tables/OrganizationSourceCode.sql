if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrganizationSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OrganizationSourceCode]
GO

CREATE TABLE [dbo].[OrganizationSourceCode] (
	[OrganizationSourceCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[OrganizationID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


