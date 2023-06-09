if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TimeSheet]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TimeSheet]
GO

CREATE TABLE [dbo].[TimeSheet] (
	[TimeSheetID] [int] IDENTITY (1, 1) NOT NULL ,
	[TimeSheetEmployeeID] [int] NULL ,
	[TimeSheetDate] [datetime] NULL ,
	[TimeSheetType] [int] NULL ,
	[TimeSheetValue] [int] NULL ,
	[TimeSheetComment] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


