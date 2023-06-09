SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorSerologies](
	[TcssDonorSerologiesId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListSerologyQuestionId] [int] NULL,
	[TcssListSerologyAnswerId] [int] NULL,
 CONSTRAINT [PK_TcssDonorSerologies] PRIMARY KEY CLUSTERED 
(
	[TcssDonorSerologiesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]') AND name = N'IX_TcssDonorSerologies_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorSerologies_TcssDonorId] ON [dbo].[TcssDonorSerologies]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorSerologies_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorSerologies] ADD  CONSTRAINT [DF_TcssDonorSerologies_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorSerologies_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]'))
ALTER TABLE [dbo].[TcssDonorSerologies]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorSerologies_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorSerologies_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]'))
ALTER TABLE [dbo].[TcssDonorSerologies] CHECK CONSTRAINT [FK_dbo_TcssDonorSerologies_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorSerologies_TcssListSerologyAnswerId_dbo_TcssListSerologyAnswer_TcssListSerologyAnswerId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]'))
ALTER TABLE [dbo].[TcssDonorSerologies]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorSerologies_TcssListSerologyAnswerId_dbo_TcssListSerologyAnswer_TcssListSerologyAnswerId] FOREIGN KEY([TcssListSerologyAnswerId])
REFERENCES [dbo].[TcssListSerologyAnswer] ([TcssListSerologyAnswerId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorSerologies_TcssListSerologyAnswerId_dbo_TcssListSerologyAnswer_TcssListSerologyAnswerId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]'))
ALTER TABLE [dbo].[TcssDonorSerologies] CHECK CONSTRAINT [FK_dbo_TcssDonorSerologies_TcssListSerologyAnswerId_dbo_TcssListSerologyAnswer_TcssListSerologyAnswerId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorSerologies_TcssListSerologyQuestionId_dbo_TcssListSerologyQuestion_TcssListSerologyQuestionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]'))
ALTER TABLE [dbo].[TcssDonorSerologies]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorSerologies_TcssListSerologyQuestionId_dbo_TcssListSerologyQuestion_TcssListSerologyQuestionId] FOREIGN KEY([TcssListSerologyQuestionId])
REFERENCES [dbo].[TcssListSerologyQuestion] ([TcssListSerologyQuestionId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorSerologies_TcssListSerologyQuestionId_dbo_TcssListSerologyQuestion_TcssListSerologyQuestionId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorSerologies]'))
ALTER TABLE [dbo].[TcssDonorSerologies] CHECK CONSTRAINT [FK_dbo_TcssDonorSerologies_TcssListSerologyQuestionId_dbo_TcssListSerologyQuestion_TcssListSerologyQuestionId]
GO
