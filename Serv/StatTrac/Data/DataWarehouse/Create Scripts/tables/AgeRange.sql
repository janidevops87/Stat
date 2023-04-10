if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AgeRange]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AgeRange]
GO

CREATE TABLE [dbo].[AgeRange] (
	[AgeRangeID] [int] IDENTITY (1, 1) NOT NULL ,
	[AgeRangeName] [char] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AgeRangeStart] [int] NULL ,
	[AgeRangeEnd] [int] NULL 
) ON [PRIMARY]
GO


