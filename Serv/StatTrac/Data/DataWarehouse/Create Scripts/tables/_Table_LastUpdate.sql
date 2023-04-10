if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_Table_LastUpdate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_Table_LastUpdate]
GO

CREATE TABLE [dbo].[_Table_LastUpdate] (
	[TableName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LastUpdated] [datetime] NOT NULL ,
	[UpdateCompleted] [datetime] NULL 
) ON [PRIMARY]
GO


