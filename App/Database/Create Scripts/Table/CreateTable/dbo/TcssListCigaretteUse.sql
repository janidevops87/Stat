SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssListCigaretteUse]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssListCigaretteUse](
	[TcssListCigaretteUseId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FieldValue] [varchar](100) NULL,
	[UnosValue] [varchar](100) NULL,
 CONSTRAINT [PK_TcssListCigaretteUse] PRIMARY KEY CLUSTERED 
(
	[TcssListCigaretteUseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListCigaretteUse_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListCigaretteUse] ADD  CONSTRAINT [DF_TcssListCigaretteUse_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListCigaretteUse_SortOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListCigaretteUse] ADD  CONSTRAINT [DF_TcssListCigaretteUse_SortOrder]  DEFAULT (1) FOR [SortOrder]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssListCigaretteUse_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssListCigaretteUse] ADD  CONSTRAINT [DF_TcssListCigaretteUse_IsActive]  DEFAULT (1) FOR [IsActive]
END
GO
