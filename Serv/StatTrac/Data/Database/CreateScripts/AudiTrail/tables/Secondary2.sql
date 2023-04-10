if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Secondary2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Secondary2]
GO

CREATE TABLE [dbo].[Secondary2] (
	[CallID] [int] NOT NULL ,
	[SecondaryAntibiotic1Name] [int] NULL ,
	[SecondaryAntibiotic1Dose] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic1StartDate] [datetime] NULL ,
	[SecondaryAntibiotic1EndDate] [datetime] NULL ,
	[SecondaryAntibiotic2Name] [int] NULL ,
	[SecondaryAntibiotic2Dose] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic2StartDate] [datetime] NULL ,
	[SecondaryAntibiotic2EndDate] [datetime] NULL ,
	[SecondaryAntibiotic3Name] [int] NULL ,
	[SecondaryAntibiotic3Dose] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic3StartDate] [datetime] NULL ,
	[SecondaryAntibiotic3EndDate] [datetime] NULL ,
	[SecondaryAntibiotic4Name] [int] NULL ,
	[SecondaryAntibiotic4Dose] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic4StartDate] [datetime] NULL ,
	[SecondaryAntibiotic4EndDate] [datetime] NULL ,
	[SecondaryAntibiotic5Name] [int] NULL ,
	[SecondaryAntibiotic5Dose] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic5StartDate] [datetime] NULL ,
	[SecondaryAntibiotic5EndDate] [datetime] NULL ,
	[SecondaryBloodProductsReceived1Type] [int] NULL ,
	[SecondaryBloodProductsReceived1Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived1TypeCC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived1TypeUnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived2Type] [int] NULL ,
	[SecondaryBloodProductsReceived2Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived2TypeCC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived2TypeUnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived3Type] [int] NULL ,
	[SecondaryBloodProductsReceived3Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived3TypeCC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived3TypeUnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused1Type] [int] NULL ,
	[SecondaryColloidsInfused1Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused1CC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused1UnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused2Type] [int] NULL ,
	[SecondaryColloidsInfused2Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused2CC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused2UnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused3Type] [int] NULL ,
	[SecondaryColloidsInfused3Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused3CC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused3UnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids1Type] [int] NULL ,
	[SecondaryCrystalloids1Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids1CC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids1UnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids2Type] [int] NULL ,
	[SecondaryCrystalloids2Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids2CC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids2UnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids3Type] [int] NULL ,
	[SecondaryCrystalloids3Units] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids3CC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids3UnitGiven] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryWBC1Date] [smalldatetime] NULL ,
	[SecondaryWBC1] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryWBC1Bands] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryWBC2Date] [smalldatetime] NULL ,
	[SecondaryWBC2] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryWBC2Bands] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryWBC3Date] [smalldatetime] NULL ,
	[SecondaryWBC3] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryWBC3Bands] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLabTemp1] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLabTemp1Date] [smalldatetime] NULL ,
	[SecondaryLabTemp1Time] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLabTemp2] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLabTemp2Date] [smalldatetime] NULL ,
	[SecondaryLabTemp2Time] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLabTemp3] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryLabTemp3Date] [smalldatetime] NULL ,
	[SecondaryLabTemp3Time] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCulture1Type] [int] NULL ,
	[SecondaryCulture1Other] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCulture1DrawnDate] [smalldatetime] NULL ,
	[SecondaryCulture1Growth] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCulture2Type] [int] NULL ,
	[SecondaryCulture2Other] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCulture2DrawnDate] [smalldatetime] NULL ,
	[SecondaryCulture2Growth] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCulture3Type] [int] NULL ,
	[SecondaryCulture3Other] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCulture3DrawnDate] [smalldatetime] NULL ,
	[SecondaryCulture3Growth] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCXRAvailable] [int] NULL ,
	[SecondaryCXR1Date] [smalldatetime] NULL ,
	[SecondaryCXR1Finding] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCXR2Date] [smalldatetime] NULL ,
	[SecondaryCXR2Finding] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCXR3Date] [smalldatetime] NULL ,
	[SecondaryCXR3Finding] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic1NameOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic2NameOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic3NameOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic4NameOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryAntibiotic5NameOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived1TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived2TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryBloodProductsReceived3TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused1TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused2TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryColloidsInfused3TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids1TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids2TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryCrystalloids3TypeOther] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryCXR1Finding] ON [dbo].[Secondary2] ([SecondaryCXR1Finding]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryCXR2Finding] ON [dbo].[Secondary2] ([SecondaryCXR2Finding]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryCXR3Finding] ON [dbo].[Secondary2] ([SecondaryCXR3Finding]) ')
GO

 CREATE    INDEX [PK_Secondary2] ON [dbo].[Secondary2]([CallID]) WITH FILLFACTOR = 90 ON [IDX]
GO


