if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveRegistryStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveRegistryStatus]
GO

CREATE TABLE [dbo].[ArchiveRegistryStatus] (
	[ID] [int] NOT NULL ,
	[RegistryStatus] [int] NULL ,
	[CallID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL	
) ON [PRIMARY]
GO


