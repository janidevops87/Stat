if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCaseStatusLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSBCaseStatusLog]
GO

CREATE TABLE [dbo].[FSBCaseStatusLog] (
	[FSBCaseId] [int] NOT NULL ,
	[FSBStatusId] [int] NOT NULL ,
	[StatusChangedDateTime] [datetime] NOT NULL ,
	[InsertedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DateInserted] [datetime] NOT NULL ,
	[DateUpdated] [datetime] NOT NULL 
) ON [PRIMARY]
GO


