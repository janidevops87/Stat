SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Api].[Queue]') AND type in (N'U'))
BEGIN
CREATE TABLE [Api].[Queue](
	[QueueId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WebReportGroupId] [int] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[Document] [ntext] NULL,
	[LastModified] [datetime] NULL,
	[OrganizationId] [int] NOT NULL,
 CONSTRAINT [PK_Queue] PRIMARY KEY CLUSTERED 
(
	[QueueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Api].[DF_Queue_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [Api].[Queue] ADD  CONSTRAINT [DF_Queue_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
