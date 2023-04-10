if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[StatEmployeeLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[StatEmployeeLog]
GO

CREATE TABLE [dbo].[StatEmployeeLog] (
	[StatEmployeeLogID] [int] IDENTITY (1, 1) NOT NULL ,
	[StatEmployeeID] [int] NULL ,
	[StatEmployeeLogDate] [datetime] NULL ,
	[StatEmployeeLogTypeID] [int] NULL ,
	[StatEmployeeLogNote] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


