if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TimePayDates]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TimePayDates]
GO

CREATE TABLE [dbo].[TimePayDates] (
	[TimePayDatesID] [int] IDENTITY (1, 1) NOT NULL ,
	[TimePayDatesStart] [datetime] NULL 
) ON [PRIMARY]
GO


