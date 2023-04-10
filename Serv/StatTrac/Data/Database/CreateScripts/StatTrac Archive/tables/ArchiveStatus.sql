if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveStatus]
GO

CREATE TABLE [dbo].[ArchiveStatus] (
	[ArchiveStatusID] [smallint] IDENTITY (1, 1) NOT NULL ,
	[TableDate] [smalldatetime] NOT NULL ,
	[Status] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO


