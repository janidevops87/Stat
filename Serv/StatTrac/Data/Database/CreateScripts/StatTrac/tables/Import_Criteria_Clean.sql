if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Criteria_Clean]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Criteria_Clean]
GO

CREATE TABLE [dbo].[Import_Criteria_Clean] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Import_Organization_Log_ID] [int] NULL ,
	[Source_Code_ID] [int] NULL ,
	[Category_ID] [int] NULL ,
	[Male_Gender_Appropriate] [smallint] NULL ,
	[Female_Gender_Appropriate] [smallint] NULL ,
	[Male_Lower_Age] [int] NULL ,
	[Male_Lower_Age_Units] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Female_Lower_Age] [int] NULL ,
	[Female_Lower_Age_Units] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Male_Upper_Age] [int] NULL ,
	[Male_Upper_Age_Units] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Female_Upper_Age] [int] NULL ,
	[Female_Upper_Age_Units] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Lower_Weight] [int] NULL ,
	[Upper_Weight] [int] NULL ,
	[Criteria_Applies_To] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Criteria_Status_Working] [int] NULL ,
	[Criteria_Group_Name] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


