SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorMedication](
	[TcssDonorMedicationId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListMedicationId] [int] NULL,
	[StartDate] [smalldatetime] NULL,
	[StopDateTime] [smalldatetime] NULL,
	[Dose] [decimal](18, 2) NULL,
	[TcssListMedicationDoseUnitId] [int] NULL,
	[Duration] [int] NULL,
 CONSTRAINT [PK_TcssDonorMedication] PRIMARY KEY CLUSTERED 
(
	[TcssDonorMedicationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]') AND name = N'IX_TcssDonorMedication_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorMedication_TcssDonorId] ON [dbo].[TcssDonorMedication]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorMedication_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorMedication] ADD  CONSTRAINT [DF_TcssDonorMedication_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedication_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]'))
ALTER TABLE [dbo].[TcssDonorMedication]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedication_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedication_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]'))
ALTER TABLE [dbo].[TcssDonorMedication] CHECK CONSTRAINT [FK_dbo_TcssDonorMedication_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedication_TcssListMedicationDoseUnitId_dbo_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]'))
ALTER TABLE [dbo].[TcssDonorMedication]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedication_TcssListMedicationDoseUnitId_dbo_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId] FOREIGN KEY([TcssListMedicationDoseUnitId])
REFERENCES [dbo].[TcssListMedicationDoseUnit] ([TcssListMedicationDoseUnitId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedication_TcssListMedicationDoseUnitId_dbo_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]'))
ALTER TABLE [dbo].[TcssDonorMedication] CHECK CONSTRAINT [FK_dbo_TcssDonorMedication_TcssListMedicationDoseUnitId_dbo_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedication_TcssListMedicationId_dbo_TcssListMedication_TcssListMedicationId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]'))
ALTER TABLE [dbo].[TcssDonorMedication]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorMedication_TcssListMedicationId_dbo_TcssListMedication_TcssListMedicationId] FOREIGN KEY([TcssListMedicationId])
REFERENCES [dbo].[TcssListMedication] ([TcssListMedicationId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorMedication_TcssListMedicationId_dbo_TcssListMedication_TcssListMedicationId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorMedication]'))
ALTER TABLE [dbo].[TcssDonorMedication] CHECK CONSTRAINT [FK_dbo_TcssDonorMedication_TcssListMedicationId_dbo_TcssListMedication_TcssListMedicationId]
GO
