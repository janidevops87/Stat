if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceLevelCustomField]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceLevelCustomField]
GO

CREATE TABLE [dbo].[ServiceLevelCustomField] (
	[ServiceLevelID] [int] NOT NULL ,
	[ServiceLevelCustomOn] [smallint] NULL ,
	[ServiceLevelCustomTextAlert] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomListAlert] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel2] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel3] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel4] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel5] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel6] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel7] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel8] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel9] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel10] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel11] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel12] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel13] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel14] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel15] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ServiceLevelCustomFieldLabel16] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


