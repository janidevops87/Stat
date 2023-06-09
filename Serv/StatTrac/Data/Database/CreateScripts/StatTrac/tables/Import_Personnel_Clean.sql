if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Personnel_Clean]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Personnel_Clean]
GO

CREATE TABLE [dbo].[Import_Personnel_Clean] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Import_Personnel_Log_ID] [int] NULL ,
	[Source_Code_ID] [int] NULL ,
	[Organization_ID] [int] NULL ,
	[First_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Middle_Name] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Last_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Person_Type_ID] [int] NULL ,
	[Home_Phone] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Work_Phone] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Cell_Phone] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Alpha_Pager] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Alpha_Pager_Email_Address] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [bit] NULL ,
	[Allow_Internet_Schedule_Access] [bit] NULL ,
	[Person_Security] [int] NULL 
) ON [PRIMARY]
GO


