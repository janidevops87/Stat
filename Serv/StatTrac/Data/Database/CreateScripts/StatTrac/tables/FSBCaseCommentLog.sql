if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseCommentLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSBCaseCommentLog]
GO

CREATE TABLE [dbo].[FSBCaseCommentLog] (
	[FSBCaseCommentLogId] [int] IDENTITY (1, 1) NOT NULL ,
	[Comment] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FSBCaseId] [int] NOT NULL ,
	[InsertedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[UpdatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DateInserted] [datetime] NOT NULL ,
	[DateUpdated] [datetime] NOT NULL 
) ON [PRIMARY]
GO


