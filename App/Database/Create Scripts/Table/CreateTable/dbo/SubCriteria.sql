SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubCriteria]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SubCriteria](
	[SubCriteriaID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaID] [int] NULL,
	[DonorCategoryID] [int] NULL,
	[SubtypeID] [int] NULL,
	[ProcessorID] [int] NULL,
	[ProcessorPrecedence] [int] NULL,
	[SubCriteriaMaleUpperAge] [smallint] NULL,
	[SubCriteriaMaleLowerAge] [smallint] NULL,
	[SubCriteriaFemaleUpperAge] [smallint] NULL,
	[SubCriteriaFemaleLowerAge] [smallint] NULL,
	[SubCriteriaGeneralRuleout] [varchar](255) NULL,
	[SubCriteriaMaleNotAppropriate] [smallint] NULL,
	[SubCriteriaFemaleNotAppropriate] [smallint] NULL,
	[SubCriteriaReferNonPotential] [smallint] NULL,
	[SubCriteriaLowerWeight] [float] NULL,
	[SubCriteriaUpperWeight] [float] NULL,
	[SubCriteriaLowerAgeUnit] [char](6) NULL,
	[SubCriteriaDisableAppropriate] [smallint] NULL,
	[SubCriteriaMaleUpperAgeUnit] [char](6) NULL,
	[SubCriteriaMaleLowerAgeUnit] [char](6) NULL,
	[SubCriteriaFemaleUpperAgeUnit] [char](6) NULL,
	[SubCriteriaFemaleLowerAgeUnit] [char](6) NULL,
	[SubCriteriaFemaleLowerWeight] [float] NULL,
	[SubCriteriaFemaleUpperWeight] [float] NULL,
 CONSTRAINT [PK_SubCriteria] PRIMARY KEY NONCLUSTERED 
(
	[SubCriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SubCriteria]') AND name = N'FK_CriteriaID')
CREATE NONCLUSTERED INDEX [FK_CriteriaID] ON [dbo].[SubCriteria]
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SubCriteria_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubCriteria]'))
ALTER TABLE [dbo].[SubCriteria]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SubCriteria_CriteriaID_dbo_Criteria_CriteriaID] FOREIGN KEY([CriteriaID])
REFERENCES [dbo].[Criteria] ([CriteriaID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SubCriteria_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubCriteria]'))
ALTER TABLE [dbo].[SubCriteria] CHECK CONSTRAINT [FK_dbo_SubCriteria_CriteriaID_dbo_Criteria_CriteriaID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SubCriteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubCriteria]'))
ALTER TABLE [dbo].[SubCriteria]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SubCriteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID] FOREIGN KEY([DonorCategoryID])
REFERENCES [dbo].[DonorCategory] ([DonorCategoryID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SubCriteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubCriteria]'))
ALTER TABLE [dbo].[SubCriteria] CHECK CONSTRAINT [FK_dbo_SubCriteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SubCriteria_SubtypeID_dbo_SubType_SubTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubCriteria]'))
ALTER TABLE [dbo].[SubCriteria]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SubCriteria_SubtypeID_dbo_SubType_SubTypeID] FOREIGN KEY([SubtypeID])
REFERENCES [dbo].[SubType] ([SubTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SubCriteria_SubtypeID_dbo_SubType_SubTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubCriteria]'))
ALTER TABLE [dbo].[SubCriteria] CHECK CONSTRAINT [FK_dbo_SubCriteria_SubtypeID_dbo_SubType_SubTypeID]
GO
