SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NDRICallSheet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NDRICallSheet](
	[NDRICallSheetId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallId] [int] NOT NULL,
	[CallDate] [smalldatetime] NULL,
	[CallTime] [varchar](10) NULL,
	[DonorNumber] [varchar](50) NULL,
	[CoordinatorName] [varchar](101) NULL,
	[Source] [varchar](50) NULL,
	[SourcePhone] [varchar](14) NULL,
	[Age] [varchar](4) NULL,
	[AgeUnit] [varchar](10) NULL,
	[RaceId] [int] NULL,
	[Gender] [char](1) NULL,
	[ABO_RH] [smallint] NULL,
	[COD_S] [smallint] NULL,
	[DOD] [smalldatetime] NULL,
	[TOD] [varchar](10) NULL,
	[CD4] [varchar](50) NULL,
	[Viral_Load] [varchar](50) NULL,
	[OtherDiseases] [varchar](1000) NULL,
	[Sepsis] [tinyint] NULL,
	[Chemotherapy] [tinyint] NULL,
	[Radiation] [tinyint] NULL,
	[SubstanceAbuse] [tinyint] NULL,
	[MedHxOther] [varchar](500) NULL,
	[AttendingHospital] [varchar](80) NULL,
	[AttendingNurse] [varchar](101) NULL,
	[AttendingPhysician] [varchar](101) NULL,
	[PhysicianPhone] [varchar](14) NULL,
	[FamilyAtHospital] [tinyint] NULL,
	[FamilyHIVStatus] [tinyint] NULL,
	[FuneralHome] [varchar](80) NULL,
	[AdditionalComments] [varchar](500) NULL,
	[COD_S_Other] [varchar](200) NULL,
 CONSTRAINT [PK_NDRICallSheet] PRIMARY KEY CLUSTERED 
(
	[NDRICallSheetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_NDRICallSheet_RaceId_dbo_Race_RaceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[NDRICallSheet]'))
ALTER TABLE [dbo].[NDRICallSheet]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_NDRICallSheet_RaceId_dbo_Race_RaceID] FOREIGN KEY([RaceId])
REFERENCES [dbo].[Race] ([RaceID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_NDRICallSheet_RaceId_dbo_Race_RaceID]') AND parent_object_id = OBJECT_ID(N'[dbo].[NDRICallSheet]'))
ALTER TABLE [dbo].[NDRICallSheet] CHECK CONSTRAINT [FK_dbo_NDRICallSheet_RaceId_dbo_Race_RaceID]
GO
