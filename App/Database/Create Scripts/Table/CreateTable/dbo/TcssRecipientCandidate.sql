SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssRecipientCandidate](
	[TcssRecipientCandidateId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssRecipientId] [int] NOT NULL,
	[TcssListRefusedByOtherCenterId] [int] NULL,
	[Why] [varchar](100) NULL,
 CONSTRAINT [PK_TcssRecipientCandidate] PRIMARY KEY CLUSTERED 
(
	[TcssRecipientCandidateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssRecipientCandidate_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssRecipientCandidate] ADD  CONSTRAINT [DF_TcssRecipientCandidate_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_dbo_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidate]'))
ALTER TABLE [dbo].[TcssRecipientCandidate]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_dbo_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId] FOREIGN KEY([TcssListRefusedByOtherCenterId])
REFERENCES [dbo].[TcssListRefusedByOtherCenter] ([TcssListRefusedByOtherCenterId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_dbo_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidate]'))
ALTER TABLE [dbo].[TcssRecipientCandidate] CHECK CONSTRAINT [FK_dbo_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_dbo_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidate_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidate]'))
ALTER TABLE [dbo].[TcssRecipientCandidate]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssRecipientCandidate_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId] FOREIGN KEY([TcssRecipientId])
REFERENCES [dbo].[TcssRecipient] ([TcssRecipientId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssRecipientCandidate_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssRecipientCandidate]'))
ALTER TABLE [dbo].[TcssRecipientCandidate] CHECK CONSTRAINT [FK_dbo_TcssRecipientCandidate_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]
GO
