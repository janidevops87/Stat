if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Message]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Message]
GO

CREATE TABLE [dbo].[Message] (
	[MessageID] [int] NOT NULL ,
	[CallID] [int] NULL ,
	[MessageCallerName] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MessageCallerPhone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MessageCallerOrganization] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[PersonID] [int] NULL ,
	[MessageTypeID] [int] NULL ,
	[MessageUrgent] [smallint] NULL ,
	[MessageDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[MessageExtension] [numeric](5, 0) NULL ,
	[MessageImportPatient] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MessageImportUNOSID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MessageImportCenter] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [PersonID] ON [dbo].[Message] ([PersonID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [MessageUrgent] ON [dbo].[Message] ([MessageUrgent]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_56_2_6] ON [dbo].[Message] ([CallID], [OrganizationID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_56_6_2] ON [dbo].[Message] ([OrganizationID], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [MessageDescription] ON [dbo].[Message] ([MessageDescription]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [Inactive] ON [dbo].[Message] ([Inactive]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [MessageExtension] ON [dbo].[Message] ([MessageExtension]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [MessageImportPatient] ON [dbo].[Message] ([MessageImportPatient]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [MessageImportUNOSID] ON [dbo].[Message] ([MessageImportUNOSID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [UpdatedFlag] ON [dbo].[Message] ([UpdatedFlag]) ')
GO

 CREATE  INDEX [CallID] ON [dbo].[Message]([CallID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [Message1] ON [dbo].[Message]([CallID], [OrganizationID], [MessageTypeID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE    INDEX [PK_Message_1__24] ON [dbo].[Message]([MessageID]) WITH FILLFACTOR = 90 ON [IDX]
GO


