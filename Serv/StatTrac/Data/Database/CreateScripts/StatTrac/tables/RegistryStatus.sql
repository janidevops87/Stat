if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RegistryStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RegistryStatus]
GO

CREATE TABLE [dbo].[RegistryStatus] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RegistryStatus] [int] NULL ,
	[CallID] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


