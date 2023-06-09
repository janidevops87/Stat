if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CallType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CallType]
GO

CREATE TABLE [dbo].[CallType] (
	[CallTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[CallTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Inactive] [smallint] NULL ,
	[Verified] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


