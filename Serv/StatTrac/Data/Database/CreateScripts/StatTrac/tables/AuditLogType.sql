if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditLogType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AuditLogType]
GO

CREATE TABLE [dbo].[AuditLogType] (
	[AuditLogTypeId] [int] IDENTITY (1, 1) NOT NULL ,
	[AuditLogTypeName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


