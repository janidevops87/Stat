SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationSourceCode](
	[OrganizationID] [int] NOT NULL,
	[SourceCodeList] [nvarchar](1000) NULL,
	[LastModified] [smalldatetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_OrganizationSourceCode] PRIMARY KEY CLUSTERED 
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationSourceCode_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationSourceCode] ADD  CONSTRAINT [DF_OrganizationSourceCode_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
