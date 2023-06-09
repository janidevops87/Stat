if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LifeLink]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LifeLink]
GO

CREATE TABLE [dbo].[LifeLink] (
	[FacilityID] [int] IDENTITY (1, 1) NOT NULL ,
	[HospitalName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HospitalAddress] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HospitalCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HospitalState] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HospitalCounty] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[HospitalPhone] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Organs] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Tissues] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Eyes] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


