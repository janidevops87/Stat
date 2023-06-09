SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorToRecipient]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorToRecipient](
	[TcssDonorToRecipientId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssRecipientId] [int] NOT NULL,
 CONSTRAINT [PK_TcssDonorToRecipient] PRIMARY KEY CLUSTERED 
(
	[TcssDonorToRecipientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorToRecipient]') AND name = N'IX_TcssDonorToRecipient_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorToRecipient_TcssDonorId] ON [dbo].[TcssDonorToRecipient]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorToRecipient_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorToRecipient] ADD  CONSTRAINT [DF_TcssDonorToRecipient_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorToRecipient_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorToRecipient]'))
ALTER TABLE [dbo].[TcssDonorToRecipient]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorToRecipient_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorToRecipient_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorToRecipient]'))
ALTER TABLE [dbo].[TcssDonorToRecipient] CHECK CONSTRAINT [FK_dbo_TcssDonorToRecipient_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorToRecipient_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorToRecipient]'))
ALTER TABLE [dbo].[TcssDonorToRecipient]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorToRecipient_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId] FOREIGN KEY([TcssRecipientId])
REFERENCES [dbo].[TcssRecipient] ([TcssRecipientId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorToRecipient_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorToRecipient]'))
ALTER TABLE [dbo].[TcssDonorToRecipient] CHECK CONSTRAINT [FK_dbo_TcssDonorToRecipient_TcssRecipientId_dbo_TcssRecipient_TcssRecipientId]
GO
