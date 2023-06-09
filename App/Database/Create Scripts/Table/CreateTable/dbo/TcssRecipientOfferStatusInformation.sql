SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferStatusInformation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssRecipientOfferStatusInformation](
	[TcssRecipientOfferStatusInformationId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssRecipientId] [int] NOT NULL,
	[CoordinatorId] [int] NULL,
	[TcssListStatusId] [int] NULL,
	[Comment] [varchar](200) NULL,
 CONSTRAINT [PK_TcssRecipientOfferStatusInformation] PRIMARY KEY CLUSTERED 
(
	[TcssRecipientOfferStatusInformationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssRecipientOfferStatusInformation_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssRecipientOfferStatusInformation] ADD  CONSTRAINT [DF_TcssRecipientOfferStatusInformation_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferStatusInformation_TcssListStatusId_dbo_TcssListStatus_TcssListStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferStatusInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferStatusInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferStatusInformation_TcssListStatusId_dbo_TcssListStatus_TcssListStatusId] FOREIGN KEY([TcssListStatusId])
REFERENCES [dbo].[TcssListStatus] ([TcssListStatusId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferStatusInformation_TcssListStatusId_dbo_TcssListStatus_TcssListStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferStatusInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferStatusInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferStatusInformation_TcssListStatusId_dbo_TcssListStatus_TcssListStatusId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferStatusInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferStatusInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferStatusInformation]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientOfferStatusInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId] FOREIGN KEY([TcssRecipientId])
REFERENCES [dbo].[TcssRecipient] ([TcssRecipientId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientOfferStatusInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientOfferStatusInformation]'))
ALTER TABLE [dbo].[TcssRecipientOfferStatusInformation] CHECK CONSTRAINT [FK_dbo_TcssRecipientOfferStatusInformation_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]
GO
