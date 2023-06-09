if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_AgeDemoCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_AgeDemoCount]
GO

CREATE TABLE [dbo].[Referral_AgeDemoCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[DonorGender] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AgeRangeID] [int] NULL ,
	[AllTypes] [int] NULL ,
	[AppropriateOrgan] [int] NULL ,
	[AppropriateBone] [int] NULL ,
	[AppropriateTissue] [int] NULL ,
	[AppropriateSkin] [int] NULL ,
	[AppropriateValves] [int] NULL ,
	[AppropriateEyes] [int] NULL ,
	[AppropriateOther] [int] NULL ,
	[AppropriateAllTissue] [int] NULL ,
	[AppropriateRO] [int] NULL ,
	[AverageAge] [int] NULL ,
	[AllTypes_Reg] [int] NULL ,
	[AppropriateOrgan_Reg] [int] NULL ,
	[AppropriateBone_Reg] [int] NULL ,
	[AppropriateTissue_Reg] [int] NULL ,
	[AppropriateSkin_Reg] [int] NULL ,
	[AppropriateValves_Reg] [int] NULL ,
	[AppropriateEyes_Reg] [int] NULL ,
	[AppropriateOther_Reg] [int] NULL ,
	[AppropriateAllTissue_Reg] [int] NULL ,
	[AppropriateRO_Reg] [int] NULL ,
	[AverageAge_Reg] [int] NULL 
) ON [PRIMARY]
GO


