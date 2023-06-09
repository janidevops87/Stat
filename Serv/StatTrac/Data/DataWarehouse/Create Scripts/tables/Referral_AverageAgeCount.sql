if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_AverageAgeCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_AverageAgeCount]
GO

CREATE TABLE [dbo].[Referral_AverageAgeCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[DonorGender] [char] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AllTypesAge] [int] NULL ,
	[AppropriateOrganAge] [int] NULL ,
	[AppropriateBoneAge] [int] NULL ,
	[AppropriateTissueAge] [int] NULL ,
	[AppropriateSkinAge] [int] NULL ,
	[AppropriateValvesAge] [int] NULL ,
	[AppropriateEyesAge] [int] NULL ,
	[AppropriateOtherAge] [int] NULL ,
	[AppropriateAllTissueAge] [int] NULL ,
	[AppropriateROAge] [int] NULL ,
	[AllTypesAge_Reg] [int] NULL ,
	[AppropriateOrganAge_Reg] [int] NULL ,
	[AppropriateBoneAge_Reg] [int] NULL ,
	[AppropriateTissueAge_Reg] [int] NULL ,
	[AppropriateSkinAge_Reg] [int] NULL ,
	[AppropriateValvesAge_Reg] [int] NULL ,
	[AppropriateEyesAge_Reg] [int] NULL ,
	[AppropriateOtherAge_Reg] [int] NULL ,
	[AppropriateAllTissueAge_Reg] [int] NULL ,
	[AppropriateROAge_Reg] [int] NULL 
) ON [PRIMARY]
GO


