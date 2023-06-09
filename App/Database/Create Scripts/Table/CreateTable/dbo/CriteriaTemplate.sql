SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaTemplate](
	[CriteriaTemplateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ProcessorID] [int] NOT NULL,
	[CriteriaTemplateName] [varchar](100) NULL,
	[SubCriteriaMaleUpperAge] [smallint] NULL,
	[SubCriteriaMaleLowerAge] [smallint] NULL,
	[SubCriteriaFemaleUpperAge] [smallint] NULL,
	[SubCriteriaFemaleLowerAge] [smallint] NULL,
	[SubCriteriaGeneralRuleout] [varchar](255) NULL,
	[SubCriteriaMaleNotAppropriate] [smallint] NULL,
	[SubCriteriaFemaleNotAppropriate] [smallint] NULL,
	[SubCriteriaReferNonPotential] [smallint] NULL,
	[SubCriteriaLowerWeight] [smallint] NULL,
	[SubCriteriaUpperWeight] [smallint] NULL,
	[SubCriteriaLowerAgeUnit] [char](6) NULL,
	[SubCriteriaDisableAppropriate] [smallint] NULL,
	[SubCriteriaMaleUpperAgeUnit] [char](6) NULL,
	[SubCriteriaMaleLowerAgeUnit] [char](6) NULL,
	[SubCriteriaFemaleUpperAgeUnit] [char](6) NULL,
	[SubCriteriaFemaleLowerAgeUnit] [char](6) NULL,
	[SubCriteriaFemaleUpperWeight] [smallint] NULL,
	[SubCriteriaFemaleLowerWeight] [smallint] NULL,
 CONSTRAINT [PK_CriteriaTemplate] PRIMARY KEY NONCLUSTERED 
(
	[CriteriaTemplateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
