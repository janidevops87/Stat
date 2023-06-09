SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssRecipientOfferInformation](
	[TcssRecipientOfferInformationId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssRecipientId] [int] NOT NULL,
	[CallId] [int] NOT NULL,
	[StatEmployeeId] [int] NULL,
	[TcssListCallTypeId] [int] NULL,
	[ImportOfferNumber] [varchar](50) NULL,
	[ClientId] [int] NULL,
	[ReferralNumber] [int] NULL,
	[MatchId] [varchar](50) NULL,
	[TcssListOrganTypeId] [int] NULL,
	[IsMultiOrganLiver] [bit] NULL,
	[IsMultiOrganKidney] [bit] NULL,
	[IsMultiOrganHeart] [bit] NULL,
	[IsMultiOrganLung] [bit] NULL,
	[IsMultiOrganIntestine] [bit] NULL,
	[IsMultiOrganPancreas] [bit] NULL,
	[IsMultiOrganOther] [bit] NULL,
	[TcssListKidneyTypeId] [int] NULL,
	[TcssListLiverTypeId] [int] NULL,
	[TcssListLungTypeId] [int] NULL,
	[OtherOtherOrganDetailOrgan] [varchar](100) NULL,
	[TcssListStatusOfImportDataId] [int] NULL,
	[StatusSetByStatEmployeeId] [int] NULL,
	[StatusSetDateTime] [datetime] NULL,
	[TcssListCloseReason1Id] [int] NULL,
	[CloseByStatEmployee1Id] [int] NULL,
	[CloseDate1] [datetime] NULL,
	[TcssListCloseReason2Id] [int] NULL,
	[CloseByStatEmployee2Id] [int] NULL,
	[CloseDate2] [datetime] NULL,
 CONSTRAINT [PK_TcssRecipientOfferInformation] PRIMARY KEY CLUSTERED 
(
	[TcssRecipientOfferInformationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]') AND name = N'IX_TcssRecipientOfferInformation_CallId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssRecipientOfferInformation_CallId] ON [dbo].[TcssRecipientOfferInformation]
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssRecipientOfferInformation_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssRecipientOfferInformation] ADD  CONSTRAINT [DF_TcssRecipientOfferInformation_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssRecipientOfferInformation_CloseDate1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssRecipientOfferInformation] ADD  CONSTRAINT [DF_TcssRecipientOfferInformation_CloseDate1]  DEFAULT (getutcdate()) FOR [CloseDate1]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssRecipientOfferInformation_CloseDate2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssRecipientOfferInformation] ADD  CONSTRAINT [DF_TcssRecipientOfferInformation_CloseDate2]  DEFAULT (getutcdate()) FOR [CloseDate2]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListKidneyTypeId_dbo_TcssListKidneyType_TcssListKidneyTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListKidneyTypeId_dbo_TcssListKidneyType_TcssListKidneyTypeId] FOREIGN KEY([TcssListKidneyTypeId])
REFERENCES [dbo].[TcssListKidneyType] ([TcssListKidneyTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListKidneyTypeId_dbo_TcssListKidneyType_TcssListKidneyTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListKidneyTypeId_dbo_TcssListKidneyType_TcssListKidneyTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListLiverTypeId_dbo_TcssListLiverType_TcssListLiverTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListLiverTypeId_dbo_TcssListLiverType_TcssListLiverTypeId] FOREIGN KEY([TcssListLiverTypeId])
REFERENCES [dbo].[TcssListLiverType] ([TcssListLiverTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListLiverTypeId_dbo_TcssListLiverType_TcssListLiverTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListLiverTypeId_dbo_TcssListLiverType_TcssListLiverTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListLungTypeId_dbo_TcssListLungType_TcssListLungTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListLungTypeId_dbo_TcssListLungType_TcssListLungTypeId] FOREIGN KEY([TcssListLungTypeId])
REFERENCES [dbo].[TcssListLungType] ([TcssListLungTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListLungTypeId_dbo_TcssListLungType_TcssListLungTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListLungTypeId_dbo_TcssListLungType_TcssListLungTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListOrganTypeId_dbo_TcssListOrganType_TcssListOrganTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListOrganTypeId_dbo_TcssListOrganType_TcssListOrganTypeId] FOREIGN KEY([TcssListOrganTypeId])
REFERENCES [dbo].[TcssListOrganType] ([TcssListOrganTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListOrganTypeId_dbo_TcssListOrganType_TcssListOrganTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListOrganTypeId_dbo_TcssListOrganType_TcssListOrganTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_dbo_TcssListStatusOfImportData_TcssListStatusOfImportDataId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_dbo_TcssListStatusOfImportData_TcssListStatusOfImportDataId] FOREIGN KEY([TcssListStatusOfImportDataId])
REFERENCES [dbo].[TcssListStatusOfImportData] ([TcssListStatusOfImportDataId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_dbo_TcssListStatusOfImportData_TcssListStatusOfImportDataId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_dbo_TcssListStatusOfImportData_TcssListStatusOfImportDataId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId] FOREIGN KEY([TcssRecipientId])
REFERENCES [dbo].[TcssRecipient] ([TcssRecipientId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]
GO
