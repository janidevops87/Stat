if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SubCriteria]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SubCriteria]
GO

CREATE TABLE [dbo].[SubCriteria] (
	[SubCriteriaID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaID] [int] NULL ,
	[DonorCategoryID] [int] NULL ,
	[SubtypeID] [int] NULL ,
	[ProcessorID] [int] NULL ,
	[ProcessorPrecedence] [int] NULL ,
	[SubCriteriaMaleUpperAge] [smallint] NULL ,
	[SubCriteriaMaleLowerAge] [smallint] NULL ,
	[SubCriteriaFemaleUpperAge] [smallint] NULL ,
	[SubCriteriaFemaleLowerAge] [smallint] NULL ,
	[SubCriteriaGeneralRuleout] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaMaleNotAppropriate] [smallint] NULL ,
	[SubCriteriaFemaleNotAppropriate] [smallint] NULL ,
	[SubCriteriaReferNonPotential] [smallint] NULL ,
	[SubCriteriaLowerWeight] [float] NULL ,
	[SubCriteriaUpperWeight] [float] NULL ,
	[SubCriteriaLowerAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaDisableAppropriate] [smallint] NULL ,
	[SubCriteriaMaleUpperAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaMaleLowerAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaFemaleUpperAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaFemaleLowerAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaFemaleLowerWeight] [float] NULL ,
	[SubCriteriaFemaleUpperWeight] [float] NULL 
) ON [PRIMARY]
GO


