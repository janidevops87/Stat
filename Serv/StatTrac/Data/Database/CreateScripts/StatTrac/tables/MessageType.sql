if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[MessageType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[MessageType]
GO

CREATE TABLE [dbo].[MessageType] (
	[MessageTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[MessageTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


