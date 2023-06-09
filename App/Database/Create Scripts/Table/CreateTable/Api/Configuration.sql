SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Api].[Configuration]') AND type in (N'U'))
BEGIN
CREATE TABLE [Api].[Configuration](
	[ConfigurationId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WebReportGroupId] [int] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[LastRun] [datetime] NULL,
	[LastModified] [datetime] NULL,
	[OrganizationId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED 
(
	[ConfigurationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Api].[DF_Configuration_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [Api].[Configuration] ADD  CONSTRAINT [DF_Configuration_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
