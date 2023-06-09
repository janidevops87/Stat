if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PersonType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PersonType]
GO

CREATE TABLE [dbo].[PersonType] (
	[PersonTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[PersonTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[PersonTypeProcurmentAgency] [smallint] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


