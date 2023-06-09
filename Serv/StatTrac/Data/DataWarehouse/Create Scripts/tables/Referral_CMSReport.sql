if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_CMSReport]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_CMSReport]
GO

CREATE TABLE [dbo].[Referral_CMSReport] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[Deaths] [int] NULL ,
	[DeathsReported] [int] NULL ,
	[Approached] [int] NULL ,
	[Approached_NonDR] [int] NULL ,
	[BDMSuitable] [int] NULL ,
	[VentedNotification] [int] NULL ,
	[Referral_CT] [int] NULL ,
	[Approach_Organ_CT] [int] NULL ,
	[Consent_Organ_CT] [int] NULL ,
	[Recovery_Organ_CT] [int] NULL ,
	[Recovery_Organ_All_CT] [int] NULL ,
	[Goals] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Actions] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


