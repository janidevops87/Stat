SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IndicationQuestionAssociated]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IndicationQuestionAssociated](
	[IndicationQuestionAssociatedID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QuestionID] [int] NULL,
	[ChildQuestionID] [int] NULL,
	[DisplayOrder] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL
) ON [PRIMARY]
END
GO
