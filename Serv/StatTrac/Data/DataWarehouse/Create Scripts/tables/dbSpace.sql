if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[dbSpace]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[dbSpace]
GO

CREATE TABLE [dbo].[dbSpace] (
	[dbSpaceID] [int] IDENTITY (1, 1) NOT NULL ,
	[tableName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[date] [datetime] NULL ,
	[reserved] [decimal](15, 0) NULL ,
	[data] [decimal](15, 0) NULL ,
	[indexp] [decimal](15, 0) NULL ,
	[unused] [decimal](15, 0) NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


