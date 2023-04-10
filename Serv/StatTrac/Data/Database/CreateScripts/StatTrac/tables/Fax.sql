if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Fax]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Fax]
GO

CREATE TABLE [dbo].[Fax] (
	[FaxId] [int] IDENTITY (1, 1) NOT NULL ,
	[FaxNumber] [char] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[OrganizationId] [int] NOT NULL 
) ON [PRIMARY]
GO


