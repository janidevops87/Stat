if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaTemplate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaTemplate]
GO

CREATE TABLE [dbo].[CriteriaTemplate] (
	[CriteriaTemplateID] [int] IDENTITY (1, 1) NOT NULL ,
	[ProcessorID] [int] NOT NULL ,
	[CriteriaTemplateName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaMaleUpperAge] [smallint] NULL ,
	[SubCriteriaMaleLowerAge] [smallint] NULL ,
	[SubCriteriaFemaleUpperAge] [smallint] NULL ,
	[SubCriteriaFemaleLowerAge] [smallint] NULL ,
	[SubCriteriaGeneralRuleout] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaMaleNotAppropriate] [smallint] NULL ,
	[SubCriteriaFemaleNotAppropriate] [smallint] NULL ,
	[SubCriteriaReferNonPotential] [smallint] NULL ,
	[SubCriteriaLowerWeight] [smallint] NULL ,
	[SubCriteriaUpperWeight] [smallint] NULL ,
	[SubCriteriaLowerAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaDisableAppropriate] [smallint] NULL ,
	[SubCriteriaMaleUpperAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaMaleLowerAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaFemaleUpperAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaFemaleLowerAgeUnit] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SubCriteriaFemaleUpperWeight] [smallint] NULL ,
	[SubCriteriaFemaleLowerWeight] [smallint] NULL 
) ON [PRIMARY]
GO


