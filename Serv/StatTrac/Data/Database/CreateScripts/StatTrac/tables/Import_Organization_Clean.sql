if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Organization_Clean]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Organization_Clean]
GO

CREATE TABLE [dbo].[Import_Organization_Clean] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Import_Organization_Log_ID] [int] NULL ,
	[Source_Code_ID] [int] NULL ,
	[Facility_Name] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Address1] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Address2] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State_ID] [int] NULL ,
	[Zip_Code] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[County_ID] [int] NULL ,
	[Facility_Type_ID] [int] NULL ,
	[Phone_ID] [int] NULL ,
	[Fax_Number] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Time_Zone] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Hospital_Code] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


