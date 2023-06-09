if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DRDSN]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DRDSN]
GO

CREATE TABLE [dbo].[DRDSN] (
	[DRDSNID] [smallint] IDENTITY (1, 1) NOT NULL ,
	[DRDSNName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DRDSNODBC] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DRDSNStateID] [tinyint] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[CreateDate] [smalldatetime] NULL ,
	[DRDSNServerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DRDSNDBName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WebServiceEnable] [int] NULL ,
	[WebServiceOrder] [int] NULL 
) ON [PRIMARY]
GO


