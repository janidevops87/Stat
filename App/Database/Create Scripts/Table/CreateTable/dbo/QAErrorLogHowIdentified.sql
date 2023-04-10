SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QAErrorLogHowIdentified]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QAErrorLogHowIdentified](
	[QAErrorLogHowIdentifiedID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QAErrorLogHowIdentifiedDescription] [varchar](250) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QAErrorLogHowIdentified] PRIMARY KEY NONCLUSTERED 
(
	[QAErrorLogHowIdentifiedID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
