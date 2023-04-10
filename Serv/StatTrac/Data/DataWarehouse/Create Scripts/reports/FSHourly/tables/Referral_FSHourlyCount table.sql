if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Referral_FSHourlyCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Referral_FSHourlyCount]
GO

CREATE TABLE [dbo].[Referral_FSHourlyCount] (
	[YearID] [int] NOT NULL ,
	[MonthID] [int] NOT NULL ,
	[DayID] [int] NOT NULL ,
	[HourID] [int] NOT NULL ,
	[SourceCodeID] [int] NOT NULL ,
	[StatEmployeeID] [int] NOT NULL ,
	[SecondaryScreeningCount] [int] NOT NULL ,
	[FamilyApproachCount] [int] NOT NULL ,
	[TotalApproachesCount] [int] NOT NULL ,
	[FamilyUnavailableCount] [int] NOT NULL ,
	[ConsentCount] [int] NOT NULL ,
	[MedSocCount] [int] NOT NULL 
) ON [PRIMARY]
GO

