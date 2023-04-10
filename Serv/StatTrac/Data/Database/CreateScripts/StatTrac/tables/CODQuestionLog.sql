if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CODQuestionLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CODQuestionLog]
GO

CREATE TABLE [dbo].[CODQuestionLog] (
	[CODQuestionLogID] [int] IDENTITY (1, 1) NOT NULL ,
	[CODQuestionsID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallID] [int] NULL ,
	[CODQuestionLogQuestionText] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


