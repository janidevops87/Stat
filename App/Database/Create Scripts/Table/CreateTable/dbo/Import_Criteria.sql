SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Criteria]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Criteria](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Import_Organization_Log_ID] [int] NULL,
	[Source_Code] [varchar](255) NULL,
	[Category] [varchar](255) NULL,
	[Male_Gender_Appropriate] [varchar](255) NULL,
	[Female_Gender_Appropriate] [varchar](255) NULL,
	[Male_Lower_Age] [varchar](255) NULL,
	[Male_Lower_Age_Units] [varchar](255) NULL,
	[Female_Lower_Age] [varchar](255) NULL,
	[Female_Lower_Age_Units] [varchar](255) NULL,
	[Male_Upper_Age] [varchar](255) NULL,
	[Male_Upper_Age_Units] [varchar](255) NULL,
	[Female_Upper_Age] [varchar](255) NULL,
	[Female_Upper_Age_Units] [varchar](255) NULL,
	[Lower_Weight] [varchar](255) NULL,
	[Upper_Weight] [varchar](255) NULL,
	[Criteria_Applies_To] [varchar](255) NULL,
	[Criteria_Status_Working] [varchar](255) NULL,
	[Criteria_Group_Name] [varchar](255) NULL,
 CONSTRAINT [PK_Import_Criteria] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
