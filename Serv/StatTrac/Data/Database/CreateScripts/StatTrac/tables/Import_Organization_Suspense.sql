if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Organization_Suspense]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Organization_Suspense]
GO

CREATE TABLE [dbo].[Import_Organization_Suspense] (
	[ID] [int] NOT NULL ,
	[Import_Organization_Log_ID] [int] NULL ,
	[Source_Code] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Facility_Name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Address1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Address2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip_Code] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[County] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Facility_Type] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Central_Phone_Number] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Fax_Number] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Time_Zone] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Hospital_Code] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


