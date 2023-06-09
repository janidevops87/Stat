SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Criteria]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Criteria](
	[CriteriaID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaGroupName] [varchar](80) NULL,
	[DonorCategoryID] [int] NULL,
	[CriteriaMaleUpperAge] [smallint] NULL,
	[CriteriaMaleLowerAge] [smallint] NULL,
	[CriteriaFemaleUpperAge] [smallint] NULL,
	[CriteriaFemaleLowerAge] [smallint] NULL,
	[CriteriaGeneralRuleout] [varchar](255) NULL,
	[Unused1] [varchar](255) NULL,
	[CriteriaMaleNotAppropriate] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[CriteriaFemaleNotAppropriate] [smallint] NULL,
	[CriteriaReferNonPotential] [smallint] NULL,
	[Unused2] [smallint] NULL,
	[CriteriaLowerWeight] [float] NULL,
	[CriteriaUpperWeight] [float] NULL,
	[CriteriaLowerAgeUnit] [varchar](6) NULL,
	[CriteriaDisableAppropriate] [smallint] NULL,
	[Unused3] [smallint] NULL,
	[Unused4] [smallint] NULL,
	[Unused5] [smallint] NULL,
	[Unused6] [smallint] NULL,
	[CriteriaMaleUpperAgeUnit] [varchar](6) NULL,
	[CriteriaMaleLowerAgeUnit] [varchar](6) NULL,
	[CriteriaFemaleUpperAgeUnit] [varchar](6) NULL,
	[CriteriaFemaleLowerAgeUnit] [varchar](6) NULL,
	[UpdatedFlag] [smallint] NULL,
	[DynamicDonorCategoryID] [int] NULL,
	[CriteriaStatus] [smallint] NULL,
	[WorkingStatusUpdatedFlag] [smallint] NULL,
	[WorkingCriteriaId] [int] NULL,
	[CriteriaDonorTracMap] [int] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[Inactive] [smallint] NULL,
	[DefaultGroupForSourceCode] [smallint] NULL,
	[CriteriaFetalDemiseUpperAge] [int] NULL,
	[CriteriaFetalDemiseLowerAge] [int] NULL,
	[CriteriaMaleUpperWeight] [float] NULL,
	[CriteriaMaleLowerWeight] [float] NULL,
	[CriteriaFemaleUpperWeight] [float] NULL,
	[CriteriaFemaleLowerWeight] [float] NULL,
	[CriteriaFetalDemiseUpperWeight] [float] NULL,
	[CriteriaFetalDemiseLowerWeight] [float] NULL,
	[CriteriaMaleUpperWeightUnit] [nvarchar](20) NULL,
	[CriteriaMaleLowerWeightUnit] [nvarchar](20) NULL,
	[CriteriaFemaleUpperWeightUnit] [nvarchar](20) NULL,
	[CriteriaFemaleLowerWeightUnit] [nvarchar](20) NULL,
	[CriteriaFetalDemiseUpperWeightUnit] [nvarchar](20) NULL,
	[CriteriaFetalDemiseLowerWeightUnit] [nvarchar](20) NULL,
 CONSTRAINT [PK_Criteria_1__13] PRIMARY KEY NONCLUSTERED 
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Criteria]') AND name = N'IDX_Criteria_CriteriaStatus_includes')
CREATE NONCLUSTERED INDEX [IDX_Criteria_CriteriaStatus_includes] ON [dbo].[Criteria]
(
	[CriteriaStatus] ASC
)
INCLUDE([CriteriaID],[DonorCategoryID],[DynamicDonorCategoryID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Criteria]') AND name = N'IDX_Criteria_DonorCategoryID_CriteriaStatus')
CREATE NONCLUSTERED INDEX [IDX_Criteria_DonorCategoryID_CriteriaStatus] ON [dbo].[Criteria]
(
	[DonorCategoryID] ASC,
	[CriteriaStatus] ASC
)
INCLUDE([CriteriaID],[CriteriaGroupName],[DynamicDonorCategoryID],[CriteriaDonorTracMap]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Criteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Criteria]'))
ALTER TABLE [dbo].[Criteria]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Criteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID] FOREIGN KEY([DonorCategoryID])
REFERENCES [dbo].[DonorCategory] ([DonorCategoryID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Criteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Criteria]'))
ALTER TABLE [dbo].[Criteria] CHECK CONSTRAINT [FK_dbo_Criteria_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Criteria_DynamicDonorCategoryID_dbo_DynamicDonorCategory_DynamicDonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Criteria]'))
ALTER TABLE [dbo].[Criteria]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Criteria_DynamicDonorCategoryID_dbo_DynamicDonorCategory_DynamicDonorCategoryID] FOREIGN KEY([DynamicDonorCategoryID])
REFERENCES [dbo].[DynamicDonorCategory] ([DynamicDonorCategoryID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Criteria_DynamicDonorCategoryID_dbo_DynamicDonorCategory_DynamicDonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Criteria]'))
ALTER TABLE [dbo].[Criteria] CHECK CONSTRAINT [FK_dbo_Criteria_DynamicDonorCategoryID_dbo_DynamicDonorCategory_DynamicDonorCategoryID]
GO
