if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Criteria_Ruleouts]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Criteria_Ruleouts]
GO

CREATE TABLE [dbo].[Import_Criteria_Ruleouts] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Import_Criteria_Ruleouts_Log_ID] [int] NULL ,
	[Source_Code_ID] [int] NULL ,
	[Category] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Ruleout_Item] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Rule_Out_If] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Criteria_Group_Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


