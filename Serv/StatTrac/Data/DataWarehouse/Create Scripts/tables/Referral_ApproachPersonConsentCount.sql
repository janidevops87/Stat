if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_ApproachPersonConsentCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_ApproachPersonConsentCount]
GO

CREATE TABLE [dbo].[Referral_ApproachPersonConsentCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[ApproachPersonID] [int] NULL ,
	[TotalApproached] [int] NULL ,
	[ConsentOrgan] [int] NULL ,
	[ConsentBone] [int] NULL ,
	[ConsentTissue] [int] NULL ,
	[ConsentSkin] [int] NULL ,
	[ConsentValves] [int] NULL ,
	[ConsentEyes] [int] NULL ,
	[ConsentOther] [int] NULL ,
	[ConsentAllTissue] [int] NULL ,
	[ApproachOrgan] [int] NULL ,
	[ApproachBone] [int] NULL ,
	[ApproachTissue] [int] NULL ,
	[ApproachSkin] [int] NULL ,
	[ApproachValves] [int] NULL ,
	[ApproachEyes] [int] NULL ,
	[ApproachOther] [int] NULL ,
	[ApproachAllTissue] [int] NULL 
) ON [PRIMARY]
GO


