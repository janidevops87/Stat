if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NoCall]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NoCall]
GO

CREATE TABLE [dbo].[NoCall] (
	[NoCallID] [int] IDENTITY (1, 1) NOT NULL ,
	[CallID] [int] NULL ,
	[NoCallTypeID] [int] NULL ,
	[NoCallDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


