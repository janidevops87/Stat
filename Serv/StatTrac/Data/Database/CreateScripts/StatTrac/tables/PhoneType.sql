if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PhoneType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PhoneType]
GO

CREATE TABLE [dbo].[PhoneType] (
	[PhoneTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[PhoneTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


