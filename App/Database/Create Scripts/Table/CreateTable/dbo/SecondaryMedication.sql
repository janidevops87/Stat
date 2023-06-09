SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecondaryMedication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SecondaryMedication](
	[CallId] [int] NOT NULL,
	[MedicationId] [int] NOT NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
 CONSTRAINT [PK_SecondaryMedication] PRIMARY KEY CLUSTERED 
(
	[CallId] ASC,
	[MedicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedication_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedication]'))
ALTER TABLE [dbo].[SecondaryMedication]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecondaryMedication_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedication_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedication]'))
ALTER TABLE [dbo].[SecondaryMedication] CHECK CONSTRAINT [FK_dbo_SecondaryMedication_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedication_MedicationId_dbo_Medication_MedicationId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedication]'))
ALTER TABLE [dbo].[SecondaryMedication]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecondaryMedication_MedicationId_dbo_Medication_MedicationId] FOREIGN KEY([MedicationId])
REFERENCES [dbo].[Medication] ([MedicationId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryMedication_MedicationId_dbo_Medication_MedicationId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryMedication]'))
ALTER TABLE [dbo].[SecondaryMedication] CHECK CONSTRAINT [FK_dbo_SecondaryMedication_MedicationId_dbo_Medication_MedicationId]
GO
