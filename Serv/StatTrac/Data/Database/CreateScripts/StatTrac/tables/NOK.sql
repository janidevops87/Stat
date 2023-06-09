if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NOK]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NOK]
GO

CREATE TABLE [dbo].[NOK] (
	[NOKID] [int] IDENTITY (1, 1) NOT NULL ,
	[NOKFirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKAddress] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKStateID] [int] NULL ,
	[NOKZip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKApproachRelation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


