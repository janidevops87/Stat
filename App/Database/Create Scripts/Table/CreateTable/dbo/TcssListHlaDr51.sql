SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssListHlaDr51]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssListHlaDr51](
	[TcssListHlaDr51Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FieldValue] [varchar](100) NULL,
	[UnosValue] [varchar](100) NULL,
 CONSTRAINT [PK_TcssListHlaDr51] PRIMARY KEY CLUSTERED 
(
	[TcssListHlaDr51Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListHlaDr51_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListHlaDr51] ADD  CONSTRAINT [DF_TcssListHlaDr51_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListHlaDr51_SortOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListHlaDr51] ADD  CONSTRAINT [DF_TcssListHlaDr51_SortOrder]  DEFAULT (1) FOR [SortOrder]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListHlaDr51_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListHlaDr51] ADD  CONSTRAINT [DF_TcssListHlaDr51_IsActive]  DEFAULT (1) FOR [IsActive]
END
GO
