SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssListT3]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssListT3](
	[TcssListT3Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FieldValue] [varchar](100) NULL,
	[UnosValue] [varchar](100) NULL,
 CONSTRAINT [PK_TcssListT3] PRIMARY KEY CLUSTERED 
(
	[TcssListT3Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListT3_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListT3] ADD  CONSTRAINT [DF_TcssListT3_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListT3_SortOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListT3] ADD  CONSTRAINT [DF_TcssListT3_SortOrder]  DEFAULT (1) FOR [SortOrder]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListT3_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListT3] ADD  CONSTRAINT [DF_TcssListT3_IsActive]  DEFAULT (1) FOR [IsActive]
END
GO
