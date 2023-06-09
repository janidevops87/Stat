if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TimeSheetType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TimeSheetType]
GO

CREATE TABLE [dbo].[TimeSheetType] (
	[TimeSheetTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[TimeSheetTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserId] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


