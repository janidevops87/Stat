if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OrganizationDeaths]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OrganizationDeaths]
GO

CREATE TABLE [dbo].[OrganizationDeaths] (
	[YearID] [int] NOT NULL ,
	[MonthID] [int] NOT NULL ,
	[OrganizationID] [int] NOT NULL ,
	[SourceCodeList] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TotalDeaths] [int] NOT NULL 
) ON [PRIMARY]
GO


