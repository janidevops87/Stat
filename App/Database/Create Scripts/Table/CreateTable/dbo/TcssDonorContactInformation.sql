SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorContactInformation](
	[TcssDonorContactInformationId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[DonorHospital] [varchar](50) NULL,
	[TcssListTimeZoneId] [int] NULL,
	[TcssListDaylightSavingsObservedId] [int] NULL,
	[Opo] [varchar](50) NULL,
	[DonorHospitalPhone] [varchar](15) NULL,
	[DonorHospitalContact] [varchar](100) NULL,
	[OpoContact] [varchar](50) NULL,
	[TransplantSurgeonContactId] [int] NULL,
	[TransplantSurgeonContactOther] [varchar](100) NULL,
	[ClinicalCoordinatorId] [int] NULL,
	[ClinicalCoordinatorOther] [varchar](100) NULL,
 CONSTRAINT [PK_TcssDonorContactInformation] PRIMARY KEY CLUSTERED 
(
	[TcssDonorContactInformationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]') AND name = N'IX_TcssDonorContactInformation_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorContactInformation_TcssDonorId] ON [dbo].[TcssDonorContactInformation]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorContactInformation_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorContactInformation] ADD  CONSTRAINT [DF_TcssDonorContactInformation_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorContactInformation_DaylightSavingsObservedId_dbo_TcssListDaylightSavingsObserved]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]'))
ALTER TABLE [dbo].[TcssDonorContactInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorContactInformation_DaylightSavingsObservedId_dbo_TcssListDaylightSavingsObserved] FOREIGN KEY([TcssListDaylightSavingsObservedId])
REFERENCES [dbo].[TcssListDaylightSavingsObserved] ([TcssListDaylightSavingsObservedId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorContactInformation_DaylightSavingsObservedId_dbo_TcssListDaylightSavingsObserved]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]'))
ALTER TABLE [dbo].[TcssDonorContactInformation] CHECK CONSTRAINT [FK_dbo_TcssDonorContactInformation_DaylightSavingsObservedId_dbo_TcssListDaylightSavingsObserved]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorContactInformation_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]'))
ALTER TABLE [dbo].[TcssDonorContactInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorContactInformation_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorContactInformation_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]'))
ALTER TABLE [dbo].[TcssDonorContactInformation] CHECK CONSTRAINT [FK_dbo_TcssDonorContactInformation_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorContactInformation_TcssListTimeZoneId_dbo_TcssListTimeZone_TcssListTimeZoneId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]'))
ALTER TABLE [dbo].[TcssDonorContactInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorContactInformation_TcssListTimeZoneId_dbo_TcssListTimeZone_TcssListTimeZoneId] FOREIGN KEY([TcssListTimeZoneId])
REFERENCES [dbo].[TcssListTimeZone] ([TcssListTimeZoneId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorContactInformation_TcssListTimeZoneId_dbo_TcssListTimeZone_TcssListTimeZoneId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorContactInformation]'))
ALTER TABLE [dbo].[TcssDonorContactInformation] CHECK CONSTRAINT [FK_dbo_TcssDonorContactInformation_TcssListTimeZoneId_dbo_TcssListTimeZone_TcssListTimeZoneId]
GO
