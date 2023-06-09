SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListFsbStatusColor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ListFsbStatusColor](
	[ListFsbStatusColorId] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastStatEmployeeId] [int] NOT NULL,
	[LastModified] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FieldValue] [nvarchar](100) NULL,
 CONSTRAINT [PK_ListFsbStatusColor] PRIMARY KEY CLUSTERED 
(
	[ListFsbStatusColorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ListFsbStatusColor_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ListFsbStatusColor] ADD  CONSTRAINT [DF_ListFsbStatusColor_LastModified]  DEFAULT (getutcdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_ListFsbStatusColor_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ListFsbStatusColor] ADD  CONSTRAINT [DF_ListFsbStatusColor_IsActive]  DEFAULT (1) FOR [IsActive]
END
GO
