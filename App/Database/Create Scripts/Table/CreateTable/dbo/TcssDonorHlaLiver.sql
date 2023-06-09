SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorHlaLiver](
	[TcssDonorHlaLiverId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListPreliminaryCrossmatchId] [int] NULL,
	[PreAdmissionHistory] [varchar](500) NULL,
	[TcssListHlaA1Id] [int] NULL,
	[TcssListHlaA2Id] [int] NULL,
	[TcssListHlaB1Id] [int] NULL,
	[TcssListHlaB2Id] [int] NULL,
	[TcssListHlaBw4Id] [int] NULL,
	[TcssListHlaBw6Id] [int] NULL,
	[TcssListHlaC1Id] [int] NULL,
	[TcssListHlaC2Id] [int] NULL,
	[TcssListHlaDr1Id] [int] NULL,
	[TcssListHlaDr2Id] [int] NULL,
	[TcssListHlaDr51Id] [int] NULL,
	[TcssListHlaDr52Id] [int] NULL,
	[TcssListHlaDr53Id] [int] NULL,
	[TcssListHlaDq1Id] [int] NULL,
	[TcssListHlaDq2Id] [int] NULL,
 CONSTRAINT [PK_TcssDonorHlaLiver] PRIMARY KEY CLUSTERED 
(
	[TcssDonorHlaLiverId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]') AND name = N'IX_TcssDonorHlaLiver_TcssDonorId')
CREATE UNIQUE NONCLUSTERED INDEX [IX_TcssDonorHlaLiver_TcssDonorId] ON [dbo].[TcssDonorHlaLiver]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorHlaLiver_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorHlaLiver] ADD  CONSTRAINT [DF_TcssDonorHlaLiver_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaA1Id_dbo_TcssListHlaA1_TcssListHlaA1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaA1Id_dbo_TcssListHlaA1_TcssListHlaA1Id] FOREIGN KEY([TcssListHlaA1Id])
REFERENCES [dbo].[TcssListHlaA1] ([TcssListHlaA1Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaA1Id_dbo_TcssListHlaA1_TcssListHlaA1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaA1Id_dbo_TcssListHlaA1_TcssListHlaA1Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaA2Id_dbo_TcssListHlaA2_TcssListHlaA2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaA2Id_dbo_TcssListHlaA2_TcssListHlaA2Id] FOREIGN KEY([TcssListHlaA2Id])
REFERENCES [dbo].[TcssListHlaA2] ([TcssListHlaA2Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaA2Id_dbo_TcssListHlaA2_TcssListHlaA2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaA2Id_dbo_TcssListHlaA2_TcssListHlaA2Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaB1Id_dbo_TcssListHlaB1_TcssListHlaB1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaB1Id_dbo_TcssListHlaB1_TcssListHlaB1Id] FOREIGN KEY([TcssListHlaB1Id])
REFERENCES [dbo].[TcssListHlaB1] ([TcssListHlaB1Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaB1Id_dbo_TcssListHlaB1_TcssListHlaB1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaB1Id_dbo_TcssListHlaB1_TcssListHlaB1Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaB2Id_dbo_TcssListHlaB2_TcssListHlaB2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaB2Id_dbo_TcssListHlaB2_TcssListHlaB2Id] FOREIGN KEY([TcssListHlaB2Id])
REFERENCES [dbo].[TcssListHlaB2] ([TcssListHlaB2Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaB2Id_dbo_TcssListHlaB2_TcssListHlaB2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaB2Id_dbo_TcssListHlaB2_TcssListHlaB2Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaBw4Id_dbo_TcssListHlaBw4_TcssListHlaBw4Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaBw4Id_dbo_TcssListHlaBw4_TcssListHlaBw4Id] FOREIGN KEY([TcssListHlaBw4Id])
REFERENCES [dbo].[TcssListHlaBw4] ([TcssListHlaBw4Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaBw4Id_dbo_TcssListHlaBw4_TcssListHlaBw4Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaBw4Id_dbo_TcssListHlaBw4_TcssListHlaBw4Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaBw6Id_dbo_TcssListHlaBw6_TcssListHlaBw6Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaBw6Id_dbo_TcssListHlaBw6_TcssListHlaBw6Id] FOREIGN KEY([TcssListHlaBw6Id])
REFERENCES [dbo].[TcssListHlaBw6] ([TcssListHlaBw6Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaBw6Id_dbo_TcssListHlaBw6_TcssListHlaBw6Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaBw6Id_dbo_TcssListHlaBw6_TcssListHlaBw6Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaC1Id_dbo_TcssListHlaC1_TcssListHlaC1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaC1Id_dbo_TcssListHlaC1_TcssListHlaC1Id] FOREIGN KEY([TcssListHlaC1Id])
REFERENCES [dbo].[TcssListHlaC1] ([TcssListHlaC1Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaC1Id_dbo_TcssListHlaC1_TcssListHlaC1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaC1Id_dbo_TcssListHlaC1_TcssListHlaC1Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaC2Id_dbo_TcssListHlaC2_TcssListHlaC2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaC2Id_dbo_TcssListHlaC2_TcssListHlaC2Id] FOREIGN KEY([TcssListHlaC2Id])
REFERENCES [dbo].[TcssListHlaC2] ([TcssListHlaC2Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaC2Id_dbo_TcssListHlaC2_TcssListHlaC2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaC2Id_dbo_TcssListHlaC2_TcssListHlaC2Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDq1Id_dbo_TcssListHlaDq1_TcssListHlaDq1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDq1Id_dbo_TcssListHlaDq1_TcssListHlaDq1Id] FOREIGN KEY([TcssListHlaDq1Id])
REFERENCES [dbo].[TcssListHlaDq1] ([TcssListHlaDq1Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDq1Id_dbo_TcssListHlaDq1_TcssListHlaDq1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDq1Id_dbo_TcssListHlaDq1_TcssListHlaDq1Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDq2Id_dbo_TcssListHlaDq2_TcssListHlaDq2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDq2Id_dbo_TcssListHlaDq2_TcssListHlaDq2Id] FOREIGN KEY([TcssListHlaDq2Id])
REFERENCES [dbo].[TcssListHlaDq2] ([TcssListHlaDq2Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDq2Id_dbo_TcssListHlaDq2_TcssListHlaDq2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDq2Id_dbo_TcssListHlaDq2_TcssListHlaDq2Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr1Id_dbo_TcssListHlaDr1_TcssListHlaDr1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr1Id_dbo_TcssListHlaDr1_TcssListHlaDr1Id] FOREIGN KEY([TcssListHlaDr1Id])
REFERENCES [dbo].[TcssListHlaDr1] ([TcssListHlaDr1Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr1Id_dbo_TcssListHlaDr1_TcssListHlaDr1Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr1Id_dbo_TcssListHlaDr1_TcssListHlaDr1Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr2Id_dbo_TcssListHlaDr2_TcssListHlaDr2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr2Id_dbo_TcssListHlaDr2_TcssListHlaDr2Id] FOREIGN KEY([TcssListHlaDr2Id])
REFERENCES [dbo].[TcssListHlaDr2] ([TcssListHlaDr2Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr2Id_dbo_TcssListHlaDr2_TcssListHlaDr2Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr2Id_dbo_TcssListHlaDr2_TcssListHlaDr2Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr51Id_dbo_TcssListHlaDr51_TcssListHlaDr51Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr51Id_dbo_TcssListHlaDr51_TcssListHlaDr51Id] FOREIGN KEY([TcssListHlaDr51Id])
REFERENCES [dbo].[TcssListHlaDr51] ([TcssListHlaDr51Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr51Id_dbo_TcssListHlaDr51_TcssListHlaDr51Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr51Id_dbo_TcssListHlaDr51_TcssListHlaDr51Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr52Id_dbo_TcssListHlaDr52_TcssListHlaDr52Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr52Id_dbo_TcssListHlaDr52_TcssListHlaDr52Id] FOREIGN KEY([TcssListHlaDr52Id])
REFERENCES [dbo].[TcssListHlaDr52] ([TcssListHlaDr52Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr52Id_dbo_TcssListHlaDr52_TcssListHlaDr52Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr52Id_dbo_TcssListHlaDr52_TcssListHlaDr52Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr53Id_dbo_TcssListHlaDr53_TcssListHlaDr53Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr53Id_dbo_TcssListHlaDr53_TcssListHlaDr53Id] FOREIGN KEY([TcssListHlaDr53Id])
REFERENCES [dbo].[TcssListHlaDr53] ([TcssListHlaDr53Id])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListHlaDr53Id_dbo_TcssListHlaDr53_TcssListHlaDr53Id]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListHlaDr53Id_dbo_TcssListHlaDr53_TcssListHlaDr53Id]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_dbo_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_dbo_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId] FOREIGN KEY([TcssListPreliminaryCrossmatchId])
REFERENCES [dbo].[TcssListPreliminaryCrossmatch] ([TcssListPreliminaryCrossmatchId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_dbo_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorHlaLiver]'))
ALTER TABLE [dbo].[TcssDonorHlaLiver] CHECK CONSTRAINT [FK_dbo_TcssDonorHlaLiver_TcssListPreliminaryCrossmatchId_dbo_TcssListPreliminaryCrossmatch_TcssListPreliminaryCrossmatchId]
GO
