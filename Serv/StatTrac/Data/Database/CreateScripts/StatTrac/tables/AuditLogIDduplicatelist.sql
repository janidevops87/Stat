if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AuditLogIDduplicatelist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AuditLogIDduplicatelist]
GO

CREATE TABLE [dbo].[AuditLogIDduplicatelist] (
	[AuditLogId] [int] NOT NULL 
) ON [PRIMARY]
GO


