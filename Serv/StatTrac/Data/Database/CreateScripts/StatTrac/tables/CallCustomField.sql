if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CallCustomField]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CallCustomField]
GO

CREATE TABLE [dbo].[CallCustomField] (
	[CallID] [int] NOT NULL ,
	[CallCustomField1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField2] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField3] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField4] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField5] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField6] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField7] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField8] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField9] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField10] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField11] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField12] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField13] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField14] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField15] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CallCustomField16] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


