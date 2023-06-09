if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SecondaryDisposition]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SecondaryDisposition]
GO

CREATE TABLE [dbo].[SecondaryDisposition] (
	[SecondaryDispositionID] [int] NOT NULL ,
	[CallID] [int] NULL ,
	[SubCriteriaID] [int] NULL ,
	[SecondaryDispositionAppropriate] [smallint] NULL ,
	[SecondaryDispositionApproach] [smallint] NULL ,
	[SecondaryDispositionConsent] [smallint] NULL ,
	[SecondaryDispositionConversion] [smallint] NULL ,
	[SecondaryDispositionCRO] [smallint] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryDispositionAppropriate] ON [dbo].[SecondaryDisposition] ([SecondaryDispositionAppropriate]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryDispositionApproach] ON [dbo].[SecondaryDisposition] ([SecondaryDispositionApproach]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryDispositionConsent] ON [dbo].[SecondaryDisposition] ([SecondaryDispositionConsent]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryDispositionConversion] ON [dbo].[SecondaryDisposition] ([SecondaryDispositionConversion]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryDispositionCRO] ON [dbo].[SecondaryDisposition] ([SecondaryDispositionCRO]) ')
GO

 CREATE    INDEX [PK_SecondaryDisposition] ON [dbo].[SecondaryDisposition]([SecondaryDispositionID]) WITH  FILLFACTOR = 90 ON [PRIMARY]
GO

 CREATE  INDEX [IDX_CallId] ON [dbo].[SecondaryDisposition]([CallID]) WITH FILLFACTOR = 90 ON [IDX]
GO


