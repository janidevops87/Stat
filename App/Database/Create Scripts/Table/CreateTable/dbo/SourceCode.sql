SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceCode](
	[SourceCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeName] [varchar](10) NULL,
	[SourceCodeDescription] [varchar](200) NULL,
	[LastModified] [datetime] NULL,
	[SourceCodeType] [int] NULL,
	[SourceCodeDefaultAlert] [nvarchar](max) NULL,
	[SourceCodeLineCheckInstruc] [varchar](255) NULL,
	[SourceCodeLineCheckInterval] [int] NULL,
	[SourceCode1Start] [varchar](5) NULL,
	[SourceCode1End] [varchar](5) NULL,
	[SourceCode2Start] [varchar](5) NULL,
	[SourceCode2End] [varchar](5) NULL,
	[SourceCode3Start] [varchar](5) NULL,
	[SourceCode3End] [varchar](5) NULL,
	[SourceCode4Start] [varchar](5) NULL,
	[SourceCode4End] [varchar](5) NULL,
	[SourceCode5Start] [varchar](5) NULL,
	[SourceCode5End] [varchar](5) NULL,
	[SourceCode6Start] [varchar](5) NULL,
	[SourceCode6End] [varchar](5) NULL,
	[SourceCode7Start] [varchar](5) NULL,
	[SourceCode7End] [varchar](5) NULL,
	[SourceCodeDisabledInterval] [smallint] NOT NULL,
	[SourceCodeNameUnAbbrev] [varchar](100) NULL,
	[SourceCodeRotationActive] [smallint] NULL,
	[SourcecodeRotationAlias] [varchar](50) NULL,
	[SourcecodeRotationTrue] [smallint] NULL,
	[SourcecodeDonorTracClient] [smallint] NULL,
	[SourceCodeDefault] [bit] NULL,
	[Inactive] [bit] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[SourceCodeOrgID] [int] NULL,
	[SourceCodeCallTypeID] [int] NULL,
 CONSTRAINT [PK___1__15] PRIMARY KEY CLUSTERED 
(
	[SourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SourceCode]') AND name = N'SourceCodeName')
CREATE NONCLUSTERED INDEX [SourceCodeName] ON [dbo].[SourceCode]
(
	[SourceCodeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SourceCode_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceCode] ADD  CONSTRAINT [DF_SourceCode_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SourceCod__Sourc__6A3C7E98]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceCode] ADD  CONSTRAINT [DF__SourceCod__Sourc__6A3C7E98]  DEFAULT (0) FOR [SourceCodeDisabledInterval]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SourceCod__Sourc__342E7F5D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceCode] ADD  DEFAULT ((0)) FOR [SourceCodeDefault]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__SourceCod__Inact__3522A396]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceCode] ADD  DEFAULT ((0)) FOR [Inactive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCode_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCode]'))
ALTER TABLE [dbo].[SourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SourceCode_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SourceCode_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceCode]'))
ALTER TABLE [dbo].[SourceCode] CHECK CONSTRAINT [FK_dbo_SourceCode_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
