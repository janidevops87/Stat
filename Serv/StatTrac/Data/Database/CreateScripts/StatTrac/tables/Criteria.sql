if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Criteria]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Criteria]
GO

CREATE TABLE [dbo].[Criteria] (
	[CriteriaID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaGroupName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorCategoryID] [int] NULL ,
	[CriteriaMaleUpperAge] [smallint] NULL ,
	[CriteriaMaleLowerAge] [smallint] NULL ,
	[CriteriaFemaleUpperAge] [smallint] NULL ,
	[CriteriaFemaleLowerAge] [smallint] NULL ,
	[CriteriaGeneralRuleout] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Unused1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CriteriaMaleNotAppropriate] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[CriteriaFemaleNotAppropriate] [smallint] NULL ,
	[CriteriaReferNonPotential] [smallint] NULL ,
	[Unused2] [smallint] NULL ,
	[CriteriaLowerWeight] [float] NULL ,
	[CriteriaUpperWeight] [float] NULL ,
	[CriteriaLowerAgeUnit] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CriteriaDisableAppropriate] [smallint] NULL ,
	[Unused3] [smallint] NULL ,
	[Unused4] [smallint] NULL ,
	[Unused5] [smallint] NULL ,
	[Unused6] [smallint] NULL ,
	[CriteriaMaleUpperAgeUnit] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CriteriaMaleLowerAgeUnit] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CriteriaFemaleUpperAgeUnit] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CriteriaFemaleLowerAgeUnit] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[DynamicDonorCategoryID] [int] NULL ,
	[CriteriaStatus] [smallint] NULL ,
	[WorkingStatusUpdatedFlag] [smallint] NULL ,
	[WorkingCriteriaId] [int] NULL ,
	[CriteriaDonorTracMap] [int] NULL 
) ON [PRIMARY]
GO


