SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssListLab]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssListLab](
	[TcssListLabId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FieldValue] [varchar](100) NULL,
	[UnosValue] [varchar](100) NULL,
	[ConfigVersion] [bigint] NOT NULL,
	[IsLiver] [bit] NOT NULL,
	[IsKidney] [bit] NOT NULL,
	[IsLung] [bit] NOT NULL,
	[IsHeart] [bit] NOT NULL,
	[IsIntestine] [bit] NOT NULL,
	[IsPancreas] [bit] NOT NULL,
	[IsHeartLung] [bit] NOT NULL,
	[IsKidneyPancreas] [bit] NOT NULL,
	[IsMultiOrgan] [bit] NOT NULL,
 CONSTRAINT [PK_TcssListLab] PRIMARY KEY CLUSTERED 
(
	[TcssListLabId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_SortOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_SortOrder]  DEFAULT (1) FOR [SortOrder]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsActive]  DEFAULT (1) FOR [IsActive]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_ConfigVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_ConfigVersion]  DEFAULT (0) FOR [ConfigVersion]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsLiver]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsLiver]  DEFAULT (0) FOR [IsLiver]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsKidney]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsKidney]  DEFAULT (0) FOR [IsKidney]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsLung]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsLung]  DEFAULT (0) FOR [IsLung]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsHeart]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsHeart]  DEFAULT (0) FOR [IsHeart]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsIntestine]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsIntestine]  DEFAULT (0) FOR [IsIntestine]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsPancreas]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsPancreas]  DEFAULT (0) FOR [IsPancreas]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsHeartLung]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsHeartLung]  DEFAULT (0) FOR [IsHeartLung]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsKidneyPancreas]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsKidneyPancreas]  DEFAULT (0) FOR [IsKidneyPancreas]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListLab_IsMultiOrgan]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListLab] ADD  CONSTRAINT [DF_TcssListLab_IsMultiOrgan]  DEFAULT (0) FOR [IsMultiOrgan]
END
GO
