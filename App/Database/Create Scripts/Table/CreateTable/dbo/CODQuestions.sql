SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CODQuestions]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CODQuestions](
	[CODQuestionsID] [int] NOT NULL,
	[CODQuestionsQuestion] [varchar](255) NULL,
	[CODQuestionsAnswer] [varchar](255) NULL,
 CONSTRAINT [PK_CODQuestions] PRIMARY KEY NONCLUSTERED 
(
	[CODQuestionsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
