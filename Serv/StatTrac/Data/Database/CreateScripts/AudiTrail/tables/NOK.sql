if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[NOK]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[NOK]
GO

CREATE TABLE [dbo].[NOK] (
	[NOKID] [int] NOT NULL ,
	[NOKFirstName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKLastName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKPhone] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKAddress] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKCity] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKStateID] [int] NULL ,
	[NOKZip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[NOKApproachRelation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO

 CREATE     INDEX [PK_NOK] ON [dbo].[NOK]([NOKID]) WITH FILLFACTOR = 90 ON [IDX]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [NOKPhone] ON [dbo].[NOK] ([NOKPhone]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [NOKAddress] ON [dbo].[NOK] ([NOKAddress]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [NOKApproachRelation] ON [dbo].[NOK] ([NOKApproachRelation]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [LastModified] ON [dbo].[NOK] ([LastModified]) ')
GO


