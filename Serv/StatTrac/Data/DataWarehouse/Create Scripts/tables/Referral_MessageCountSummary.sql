if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_MessageCountSummary]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_MessageCountSummary]
GO

CREATE TABLE [dbo].[Referral_MessageCountSummary] (
	[YearID] [int] NULL ,
	[MonthID] [int] NULL ,
	[DayID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[TotalMessages] [smallint] NULL ,
	[TotalImports] [smallint] NULL 
) ON [PRIMARY]
GO


