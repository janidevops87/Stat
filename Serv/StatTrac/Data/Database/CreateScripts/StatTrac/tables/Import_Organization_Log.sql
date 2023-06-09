if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_Organization_Log]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Import_Organization_Log]
GO

CREATE TABLE [dbo].[Import_Organization_Log] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RunStart] [datetime] NULL ,
	[RunEnd] [datetime] NULL ,
	[RunStatus] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RecordsTotal] [int] NULL ,
	[RecordsSuspended] [int] NULL ,
	[RecordsAdded] [int] NULL ,
	[RecordsUpdated] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]
GO


