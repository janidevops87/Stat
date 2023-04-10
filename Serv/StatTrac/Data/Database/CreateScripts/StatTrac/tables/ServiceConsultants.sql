if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceConsultants]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceConsultants]
GO

CREATE TABLE [dbo].[ServiceConsultants] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Name] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Email] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonType] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


