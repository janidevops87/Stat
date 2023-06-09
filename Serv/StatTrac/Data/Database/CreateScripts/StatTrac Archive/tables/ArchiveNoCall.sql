if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveNoCall]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveNoCall]
GO

CREATE TABLE [dbo].[ArchiveNoCall] (
	[NoCallID] [int] NOT NULL ,
	[CallID] [int] NULL ,
	[NoCallTypeID] [int] NULL ,
	[NoCallDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


