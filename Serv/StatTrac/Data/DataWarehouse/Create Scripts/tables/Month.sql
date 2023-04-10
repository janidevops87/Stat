if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Month]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Month]
GO

CREATE TABLE [dbo].[Month] (
	[MonthID] [int] NOT NULL ,
	[MonthName] [char] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MonthAbbrv] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


