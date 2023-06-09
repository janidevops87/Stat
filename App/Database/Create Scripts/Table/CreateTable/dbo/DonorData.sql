SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorData](
	[DonorDataId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[DonorDataMiddleName] [varchar](20) NULL,
	[DonorDataLicense] [varchar](9) NULL,
	[DonorDataAddress] [varchar](40) NULL,
	[DonorDataCity] [varchar](25) NULL,
	[DonorDataState] [varchar](2) NULL,
	[DonorDataZip] [varchar](10) NULL,
	[DonorDataNotAvailable] [bit] NULL,
	[LastModified] [smalldatetime] NULL,
	[MultipleDonorsFound] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_DonorData] PRIMARY KEY CLUSTERED 
(
	[DonorDataId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DonorData]') AND name = N'IX_CallId')
CREATE NONCLUSTERED INDEX [IX_CallId] ON [dbo].[DonorData]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorData]'))
ALTER TABLE [dbo].[DonorData]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorData]'))
ALTER TABLE [dbo].[DonorData] CHECK CONSTRAINT [FK_dbo_DonorData_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
