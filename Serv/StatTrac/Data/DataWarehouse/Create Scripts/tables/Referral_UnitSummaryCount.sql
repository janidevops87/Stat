if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_UnitSummaryCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_UnitSummaryCount]
GO

CREATE TABLE [dbo].[Referral_UnitSummaryCount] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[SubLocationID] [int] NULL ,
	[SubLocationLevel] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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


