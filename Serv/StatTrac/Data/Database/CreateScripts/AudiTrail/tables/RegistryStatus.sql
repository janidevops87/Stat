if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RegistryStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RegistryStatus]
GO

CREATE TABLE [dbo].[RegistryStatus] (
	[ID] [int] NOT NULL ,
	[RegistryStatus] [int] NULL ,
	[CallID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL 
) ON [PRIMARY]
GO

 CREATE    INDEX [PK_RegistryStatus] ON [dbo].[RegistryStatus]([ID]) WITH FILLFACTOR = 90 ON [IDX]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [LastModified] ON [dbo].[RegistryStatus] ([LastModified]) ')
GO


