SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Credential]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Credential](
	[CredentialID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Credential] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_Credential] PRIMARY KEY CLUSTERED 
(
	[CredentialID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_Credential_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Credential] ADD  CONSTRAINT [DF_Credential_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
