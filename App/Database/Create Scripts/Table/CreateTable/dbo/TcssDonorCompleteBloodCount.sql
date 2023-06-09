SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorCompleteBloodCount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorCompleteBloodCount](
	[TcssDonorCompleteBloodCountId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[SampleDateTime] [smalldatetime] NULL,
	[Wbc] [varchar](50) NULL,
	[Rbc] [varchar](50) NULL,
	[Hgb] [varchar](50) NULL,
	[Hct] [varchar](50) NULL,
	[Plt] [varchar](50) NULL,
	[Bands] [decimal](18, 2) NULL,
 CONSTRAINT [PK_TcssDonorCompleteBloodCount] PRIMARY KEY CLUSTERED 
(
	[TcssDonorCompleteBloodCountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorCompleteBloodCount]') AND name = N'IX_TcssDonorCompleteBloodCount_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorCompleteBloodCount_TcssDonorId] ON [dbo].[TcssDonorCompleteBloodCount]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorCompleteBloodCount_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorCompleteBloodCount] ADD  CONSTRAINT [DF_TcssDonorCompleteBloodCount_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCompleteBloodCount_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCompleteBloodCount]'))
ALTER TABLE [dbo].[TcssDonorCompleteBloodCount]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_TcssDonorCompleteBloodCount_TcssDonorId_dbo_TcssDonor_TcssDonorId] FOREIGN KEY([TcssDonorId])
REFERENCES [dbo].[TcssDonor] ([TcssDonorId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_TcssDonorCompleteBloodCount_TcssDonorId_dbo_TcssDonor_TcssDonorId]') AND parent_object_id = OBJECT_ID(N'[dbo].[TcssDonorCompleteBloodCount]'))
ALTER TABLE [dbo].[TcssDonorCompleteBloodCount] CHECK CONSTRAINT [FK_dbo_TcssDonorCompleteBloodCount_TcssDonorId_dbo_TcssDonor_TcssDonorId]
GO
