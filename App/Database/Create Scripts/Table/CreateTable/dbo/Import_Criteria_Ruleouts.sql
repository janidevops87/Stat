SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Criteria_Ruleouts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Criteria_Ruleouts](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Import_Criteria_Ruleouts_Log_ID] [int] NULL,
	[Source_Code_ID] [int] NULL,
	[Category] [varchar](255) NULL,
	[Ruleout_Item] [varchar](255) NULL,
	[Rule_Out_If] [varchar](255) NULL,
	[Criteria_Group_Name] [varchar](255) NULL,
 CONSTRAINT [PK_Import_Criteria_Ruleouts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
