if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AuditLog]
GO

CREATE TABLE [dbo].[AuditLog] (
	[AuditLogId] [int] IDENTITY (1, 1) NOT NULL ,
	[AuditLogTypeId] [int] NOT NULL ,
	[AuditLogRecordTypeId] [int] NOT NULL ,
	[AuditLogSourceRecordId] [int] NOT NULL ,
	[AuditLogSourceParentId] [int] NOT NULL ,
	[AuditLogPersonId] [int] NOT NULL ,
	[AuditLogPersonName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[AuditLogOrganizationName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[AuditLogLocalDateTime] [smalldatetime] NOT NULL ,
	[AuditLogServerDateTime] [smalldatetime] NOT NULL ,
	[AuditLogStatusId] [smallint] NULL 
) ON [PRIMARY]
GO


