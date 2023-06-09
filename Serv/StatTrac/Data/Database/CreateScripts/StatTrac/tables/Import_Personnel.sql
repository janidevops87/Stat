if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Personnel]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Personnel]
GO

CREATE TABLE [dbo].[Import_Personnel] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Import_Personnel_Log_ID] [int] NULL ,
	[Source_Code_ID] [int] NULL ,
	[Organization_ID] [int] NULL ,
	[First_Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Middle_Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Last_Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Role] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Home_Phone] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Work_Phone] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Cell_Phone] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Alpha_Pager] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Alpha_Pager_Email_Address] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Allow_Internet_Schedule_Access] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Person_Security] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


