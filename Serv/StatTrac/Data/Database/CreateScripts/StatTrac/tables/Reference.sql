if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Reference]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Reference]
GO

CREATE TABLE [dbo].[Reference] (
	[ReferenceID] [int] IDENTITY (1, 1) NOT NULL ,
	[ReferenceText] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ReferenceTypeID] [int] NULL ,
	[Verified] [tinyint] NULL ,
	[LastModified] [datetime] NULL ,
	[Unused1] [numeric](7, 0) NULL ,
	[Unused2] [numeric](7, 0) NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


