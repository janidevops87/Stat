if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_FSTypeCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_FSTypeCount]
GO

CREATE TABLE [dbo].[Referral_FSTypeCount] (
	[YearID] [int] NOT NULL ,
	[MonthID] [int] NOT NULL ,
	[OrganizationID] [int] NOT NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[FST] [int] NULL ,
	[fsSecondary] [int] NULL ,
	[fsApproach] [int] NULL ,
	[fsBillMedSoc] [int] NULL 
) ON [PRIMARY]
GO


