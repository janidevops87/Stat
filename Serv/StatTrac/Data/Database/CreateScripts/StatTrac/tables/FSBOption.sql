if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBOption]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSBOption]
GO

CREATE TABLE [dbo].[FSBOption] (
	[OptionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[OptionValue] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[InsertedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[UpdatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DateInserted] [datetime] NOT NULL ,
	[DateUpdated] [datetime] NOT NULL 
) ON [PRIMARY]
GO


