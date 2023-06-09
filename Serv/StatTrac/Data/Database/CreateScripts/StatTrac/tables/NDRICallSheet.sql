if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NDRICallSheet]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NDRICallSheet]
GO

CREATE TABLE [dbo].[NDRICallSheet] (
	[NDRICallSheetId] [int] IDENTITY (1, 1) NOT NULL ,
	[CallId] [int] NOT NULL ,
	[CallDate] [smalldatetime] NULL ,
	[CallTime] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CoordinatorName] [varchar] (101) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Source] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourcePhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Age] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AgeUnit] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RaceId] [int] NULL ,
	[Gender] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ABO_RH] [smallint] NULL ,
	[COD_S] [smallint] NULL ,
	[DOD] [smalldatetime] NULL ,
	[TOD] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CD4] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Viral_Load] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OtherDiseases] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Sepsis] [tinyint] NULL ,
	[Chemotherapy] [tinyint] NULL ,
	[Radiation] [tinyint] NULL ,
	[SubstanceAbuse] [tinyint] NULL ,
	[MedHxOther] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AttendingHospital] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AttendingNurse] [varchar] (101) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AttendingPhysician] [varchar] (101) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PhysicianPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FamilyAtHospital] [tinyint] NULL ,
	[FamilyHIVStatus] [tinyint] NULL ,
	[FuneralHome] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AdditionalComments] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[COD_S_Other] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


