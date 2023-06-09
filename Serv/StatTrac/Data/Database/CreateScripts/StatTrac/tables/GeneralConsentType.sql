if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GeneralConsentType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[GeneralConsentType]
GO

CREATE TABLE [dbo].[GeneralConsentType] (
	[GeneralConsentTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[GeneralConsentTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


