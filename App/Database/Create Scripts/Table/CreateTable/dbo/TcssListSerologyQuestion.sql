SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssListSerologyQuestion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssListSerologyQuestion](
	[TcssListSerologyQuestionId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FieldValue] [varchar](100) NULL,
	[UnosValue] [varchar](100) NULL,
	[ConfigVersion] [bigint] NOT NULL,
 CONSTRAINT [PK_TcssListSerologyQuestion] PRIMARY KEY CLUSTERED 
(
	[TcssListSerologyQuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListSerologyQuestion_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListSerologyQuestion] ADD  CONSTRAINT [DF_TcssListSerologyQuestion_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListSerologyQuestion_SortOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListSerologyQuestion] ADD  CONSTRAINT [DF_TcssListSerologyQuestion_SortOrder]  DEFAULT (1) FOR [SortOrder]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListSerologyQuestion_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListSerologyQuestion] ADD  CONSTRAINT [DF_TcssListSerologyQuestion_IsActive]  DEFAULT (1) FOR [IsActive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListSerologyQuestion_ConfigVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListSerologyQuestion] ADD  CONSTRAINT [DF_TcssListSerologyQuestion_ConfigVersion]  DEFAULT (0) FOR [ConfigVersion]
END
GO
