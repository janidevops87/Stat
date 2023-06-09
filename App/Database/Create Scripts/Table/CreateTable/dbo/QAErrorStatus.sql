SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QAErrorStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QAErrorStatus](
	[QAErrorStatusID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QAErrorStatusDescription] [varchar](255) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QAErrorStatus] PRIMARY KEY NONCLUSTERED 
(
	[QAErrorStatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
