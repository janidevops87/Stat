if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LEASETYPE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LEASETYPE]
GO

CREATE TABLE [dbo].[LEASETYPE] (
	[ID] [int] NOT NULL ,
	[Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Description] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


