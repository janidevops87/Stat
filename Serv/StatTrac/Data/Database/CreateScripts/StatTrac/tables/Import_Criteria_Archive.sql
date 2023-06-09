if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Criteria_Archive]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Criteria_Archive]
GO

CREATE TABLE [dbo].[Import_Criteria_Archive] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Import_Organization_Log_ID] [int] NULL ,
	[Source_Code_ID] [int] NULL ,
	[Category_ID] [int] NULL ,
	[Male_Gender_Appropriate] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Female_Gender_Appropriate] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Male_Lower_Age] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Male_Lower_Age_Units] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Female_Lower_Age] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Female_Lower_Age_Units] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Male_Upper_Age] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Male_Upper_Age_Units] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Female_Upper_Age] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Female_Upper_Age_Units] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Lower_Weight] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Upper_Weight] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Criteria_Applies_To] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Criteria_Status_Working] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Criteria_Group_Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


