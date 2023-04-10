if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CODQuestions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CODQuestions]
GO

CREATE TABLE [dbo].[CODQuestions] (
	[CODQuestionsID] [int] NOT NULL ,
	[CODQuestionsQuestion] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CODQuestionsAnswer] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


