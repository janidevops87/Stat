SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorStatusInformation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssDonorStatusInformation](
	[TcssDonorStatusInformationId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[TcssDonorId] [int] NOT NULL,
	[DateTime] [smalldatetime] NULL,
	[StatEmployeeId] [int] NULL,
	[TcssListStatusId] [int] NULL,
	[Comment] [varchar](200) NULL,
 CONSTRAINT [PK_TcssDonorStatusInformation] PRIMARY KEY CLUSTERED 
(
	[TcssDonorStatusInformationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[TcssDonorStatusInformation]') AND name = N'IX_TcssDonorStatusInformation_TcssDonorId')
CREATE NONCLUSTERED INDEX [IX_TcssDonorStatusInformation_TcssDonorId] ON [dbo].[TcssDonorStatusInformation]
(
	[TcssDonorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssDonorStatusInformation_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssDonorStatusInformation] ADD  CONSTRAINT [DF_TcssDonorStatusInformation_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
