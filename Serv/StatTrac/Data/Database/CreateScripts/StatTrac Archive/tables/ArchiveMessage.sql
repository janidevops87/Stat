if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveMessage]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveMessage]
GO

CREATE TABLE [dbo].[ArchiveMessage] (
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


