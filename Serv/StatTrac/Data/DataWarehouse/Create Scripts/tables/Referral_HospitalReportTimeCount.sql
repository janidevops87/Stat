if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_HospitalReportTimeCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_HospitalReportTimeCount]
GO

CREATE TABLE [dbo].[Referral_HospitalReportTimeCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[TimeRangeID] [int] NULL ,
	[AllTypes] [int] NULL ,
	[AppropriateOrgan] [int] NULL ,
	[AppropriateBone] [int] NULL ,
	[AppropriateTissue] [int] NULL ,
	[AppropriateSkin] [int] NULL ,
	[AppropriateValves] [int] NULL ,
	[AppropriateEyes] [int] NULL ,
	[AppropriateOther] [int] NULL ,
	[AppropriateAllTissue] [int] NULL ,
	[AppropriateRO] [int] NULL 
) ON [PRIMARY]
GO


