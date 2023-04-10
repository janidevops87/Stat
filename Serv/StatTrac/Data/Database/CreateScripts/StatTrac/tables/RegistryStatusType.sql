if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RegistryStatusType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RegistryStatusType]
GO

CREATE TABLE [dbo].[RegistryStatusType] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RegistryType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


