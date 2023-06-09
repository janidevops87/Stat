if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Weekday]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Weekday]
GO

CREATE TABLE [dbo].[Weekday] (
	[WeekdayID] [int] IDENTITY (1, 1) NOT NULL ,
	[WeekdayName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


