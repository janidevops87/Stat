SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecondaryMedicationOther]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SecondaryMedicationOther](
	[SecondaryMedicationOtherId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallId] [int] NOT NULL,
	[MedicationId] [int] NOT NULL,
	[SecondaryMedicationOtherTypeUse] [varchar](100) NOT NULL,
	[SecondaryMedicationOtherName] [varchar](100) NULL,
	[SecondaryMedicationOtherDose] [varchar](100) NULL,
	[SecondaryMedicationOtherStartDate] [smalldatetime] NULL,
	[SecondaryMedicationOtherEndDate] [smalldatetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
 CONSTRAINT [PK_SecondaryMedicationOther] PRIMARY KEY NONCLUSTERED 
(
	[SecondaryMedicationOtherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SecondaryMedicationOther]') AND name = N'IDX_SecondaryMedicationOther_CallId')
CREATE CLUSTERED INDEX [IDX_SecondaryMedicationOther_CallId] ON [dbo].[SecondaryMedicationOther]
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedicationOther_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedicationOther]'))
ALTER TABLE [dbo].[SecondaryMedicationOther]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecondaryMedicationOther_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedicationOther_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedicationOther]'))
ALTER TABLE [dbo].[SecondaryMedicationOther] CHECK CONSTRAINT [FK_dbo_SecondaryMedicationOther_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedicationOther_MedicationId_dbo_Medication_MedicationId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedicationOther]'))
ALTER TABLE [dbo].[SecondaryMedicationOther]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecondaryMedicationOther_MedicationId_dbo_Medication_MedicationId] FOREIGN KEY([MedicationId])
REFERENCES [dbo].[Medication] ([MedicationId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedicationOther_MedicationId_dbo_Medication_MedicationId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedicationOther]'))
ALTER TABLE [dbo].[SecondaryMedicationOther] CHECK CONSTRAINT [FK_dbo_SecondaryMedicationOther_MedicationId_dbo_Medication_MedicationId]
GO
