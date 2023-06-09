SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Criteria_Clean]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Criteria_Clean](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Import_Organization_Log_ID] [int] NULL,
	[Source_Code_ID] [int] NULL,
	[Category_ID] [int] NULL,
	[Male_Gender_Appropriate] [smallint] NULL,
	[Female_Gender_Appropriate] [smallint] NULL,
	[Male_Lower_Age] [int] NULL,
	[Male_Lower_Age_Units] [varchar](6) NULL,
	[Female_Lower_Age] [int] NULL,
	[Female_Lower_Age_Units] [varchar](6) NULL,
	[Male_Upper_Age] [int] NULL,
	[Male_Upper_Age_Units] [varchar](6) NULL,
	[Female_Upper_Age] [int] NULL,
	[Female_Upper_Age_Units] [varchar](6) NULL,
	[Lower_Weight] [int] NULL,
	[Upper_Weight] [int] NULL,
	[Criteria_Applies_To] [varchar](255) NULL,
	[Criteria_Status_Working] [int] NULL,
	[Criteria_Group_Name] [varchar](80) NULL,
 CONSTRAINT [PK_Import_Criteria_Clean] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
