SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorTest]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorTest](
	[TcssDonorTestId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[TcssListTestTypeId] [int] NULL,
	[TestDateTime] [smalldatetime] NULL,
	[Interpretation] [varchar](5000) NULL,
 CONSTRAINT [PK_TcssDonorTest] PRIMARY KEY CLUSTERED 
(
	[TcssDonorTestId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorTest]') AND name = N'IX_TcssDonorTest_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorTest_TcssDonorId] ON [dbo].[TcssDonorTest]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorTest_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorTest] ADD  CONSTRAINT [DF_TcssDonorTest_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorTest_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorTest]'))
ALTER TABLE [dbo].[TcssDonorTest]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorTest_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorTest_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorTest]'))
ALTER TABLE [dbo].[TcssDonorTest] CHECK CONSTRAINT [FK_dbo_TcssDonorTest_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorTest_TcssListTestTypeId_dbo_TcssListTestType_TcssListTestTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorTest]'))
ALTER TABLE [dbo].[TcssDonorTest]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorTest_TcssListTestTypeId_dbo_TcssListTestType_TcssListTestTypeId] FOREIGN KEY([TcssListTestTypeId])
REFERENCES [dbo].[TcssListTestType] ([TcssListTestTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorTest_TcssListTestTypeId_dbo_TcssListTestType_TcssListTestTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorTest]'))
ALTER TABLE [dbo].[TcssDonorTest] CHECK CONSTRAINT [FK_dbo_TcssDonorTest_TcssListTestTypeId_dbo_TcssListTestType_TcssListTestTypeId]
GO
