if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrganizationSuppliedData]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OrganizationSuppliedData]
GO

CREATE TABLE [dbo].[OrganizationSuppliedData] (
	[YearID] [int] NOT NULL ,
	[MonthID] [int] NOT NULL ,
	[OrganizationID] [int] NOT NULL ,
	[SourceCodeList] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OnTimeReferrals] [int] NULL 
) ON [PRIMARY]
GO


