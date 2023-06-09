SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidateDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssRecipientCandidateDetail](
	[TcssRecipientCandidateDetailId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssRecipientId] [int] NOT NULL,
	[SequenceNumber] [int] NULL,
	[CandidateFirstName] [varchar](50) NULL,
	[CandidateLastName] [varchar](50) NULL,
	[EvaluatedBy] [varchar](50) NULL,
	[TcssListOfferStatusId] [int] NULL,
	[PrimaryTcssListRefusalReasonId] [int] NULL,
	[SecondaryTcssListRefusalReasonId] [int] NULL,
	[PrimaryTcssListRefusalReasonComment] [varchar](100) NULL,
	[SecondaryTcssListRefusalReasonComment] [varchar](100) NULL,
	[RefusalComment] [varchar](250) NULL,
 CONSTRAINT [PK_TcssRecipientCandidateDetail] PRIMARY KEY CLUSTERED 
(
	[TcssRecipientCandidateDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssRecipientCandidateDetail_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssRecipientCandidateDetail] ADD  CONSTRAINT [DF_TcssRecipientCandidateDetail_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidateDetail_TcssListOfferStatusId_dbo_TcssListOfferStatus_TcssListOfferStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidateDetail]'))
ALTER TABLE [dbo].[TcssRecipientCandidateDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientCandidateDetail_TcssListOfferStatusId_dbo_TcssListOfferStatus_TcssListOfferStatusId] FOREIGN KEY([TcssListOfferStatusId])
REFERENCES [dbo].[TcssListOfferStatus] ([TcssListOfferStatusId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidateDetail_TcssListOfferStatusId_dbo_TcssListOfferStatus_TcssListOfferStatusId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidateDetail]'))
ALTER TABLE [dbo].[TcssRecipientCandidateDetail] CHECK CONSTRAINT [FK_dbo_TcssRecipientCandidateDetail_TcssListOfferStatusId_dbo_TcssListOfferStatus_TcssListOfferStatusId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidateDetail_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidateDetail]'))
ALTER TABLE [dbo].[TcssRecipientCandidateDetail]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientCandidateDetail_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId] FOREIGN KEY([TcssRecipientId])
REFERENCES [dbo].[TcssRecipient] ([TcssRecipientId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidateDetail_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidateDetail]'))
ALTER TABLE [dbo].[TcssRecipientCandidateDetail] CHECK CONSTRAINT [FK_dbo_TcssRecipientCandidateDetail_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]
GO
