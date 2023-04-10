if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditLogRecordType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AuditLogRecordType]
GO

CREATE TABLE [dbo].[AuditLogRecordType] (
	[AuditLogRecordTypeId] [int] IDENTITY (1, 1) NOT NULL ,
	[AuditLogRecordTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


