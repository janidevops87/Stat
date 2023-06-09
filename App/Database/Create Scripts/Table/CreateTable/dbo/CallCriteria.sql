SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallCriteria]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CallCriteria](
	[CallID] [int] NOT NULL,
	[OrganCriteriaID] [int] NULL,
	[BoneCriteriaID] [int] NULL,
	[TissueCriteriaID] [int] NULL,
	[SkinCriteriaID] [int] NULL,
	[ValvesCriteriaID] [int] NULL,
	[EyesCriteriaID] [int] NULL,
	[OtherCriteriaID] [int] NULL,
	[ServiceLevelID] [int] NULL,
 CONSTRAINT [PK_CallCriteria] PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
