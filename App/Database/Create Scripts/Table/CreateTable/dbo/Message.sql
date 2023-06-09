SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Message]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Message](
	[MessageID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[MessageCallerName] [varchar](80) NULL,
	[MessageCallerPhone] [varchar](20) NULL,
	[MessageCallerOrganization] [varchar](80) NULL,
	[OrganizationID] [int] NULL,
	[PersonID] [int] NULL,
	[MessageTypeID] [int] NULL,
	[MessageUrgent] [smallint] NULL,
	[MessageDescription] [varchar](1000) NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[MessageExtension] [numeric](5, 0) NULL,
	[MessageImportPatient] [varchar](50) NULL,
	[MessageImportUNOSID] [varchar](20) NULL,
	[MessageImportCenter] [varchar](5) NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_Message_1__24] PRIMARY KEY NONCLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX],
CONSTRAINT [Dbo_Message_Unique_CallId] UNIQUE NONCLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Message]') AND name = N'IDX_Message_CallID')
CREATE CLUSTERED INDEX [IDX_Message_CallID] ON [dbo].[Message]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Message]') AND name = N'IDX_Message_CallId_OrganizationId_MessageTypeId')
CREATE NONCLUSTERED INDEX [IDX_Message_CallId_OrganizationId_MessageTypeId] ON [dbo].[Message]
(
	[CallID] ASC,
	[OrganizationID] ASC,
	[MessageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Dbo_Message_Unique_CallId]') AND type = 'UQ')
BEGIN
	ALTER TABLE dbo.[Message] ADD CONSTRAINT [Dbo_Message_Unique_CallId] UNIQUE NONCLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
GO
