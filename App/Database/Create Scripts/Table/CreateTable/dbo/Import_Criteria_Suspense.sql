SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Criteria_Suspense]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Criteria_Suspense](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Import_Organization_Log_ID] [int] NULL,
	[Source_Code_ID] [int] NULL,
	[Category] [varchar](20) NULL,
	[Male_Gender_Appropriate] [bit] NULL,
	[Female_Gender_Appropriate] [bit] NULL,
	[Male_Lower_Age] [int] NULL,
	[Male_Lower_Age_Units] [varchar](10) NULL,
	[Female_Lower_Age] [int] NULL,
	[Female_Lower_Age_Units] [varchar](10) NULL,
	[Male_Upper_Age] [int] NULL,
	[Male_Upper_Age_Units] [varchar](10) NULL,
	[Female_Upper_Age] [int] NULL,
	[Female_Upper_Age_Units] [varchar](10) NULL,
	[Male_Lower_Weight] [int] NULL,
	[Male_Upper_Weight] [int] NULL,
	[Female_Lower_Weight] [int] NULL,
	[Female_Upper_Weight] [int] NULL,
	[Criteria_Status_Working] [int] NULL,
	[Criteria_Group_Name] [varchar](50) NULL,
 CONSTRAINT [PK_Import_Criteria_Suspense] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
