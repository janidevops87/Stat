if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditLogStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AuditLogStatus]
GO

CREATE TABLE [dbo].[AuditLogStatus] (
	[AuditLogStatusId] [int] IDENTITY (0, 1) NOT NULL ,
	[AuditLogStatusName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[AuditLogStatusDescription] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


