if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveLOCall]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveLOCall]
GO

CREATE TABLE [dbo].[ArchiveLOCall] (
	[LOCallID] [int] NOT NULL ,
	[CallID] [int] NOT NULL ,
	[StatEmployeeID] [smallint] NULL ,
	[LOCallTotalTime] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


