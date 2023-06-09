SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssListTotalParenteralNutrition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssListTotalParenteralNutrition](
	[TcssListTotalParenteralNutritionId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NULL,
	[LastUpdateDate] [datetime] NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NULL,
	[FieldValue] [varchar](100) NULL,
	[UnosValue] [varchar](100) NULL
) ON [PRIMARY]
END
GO
