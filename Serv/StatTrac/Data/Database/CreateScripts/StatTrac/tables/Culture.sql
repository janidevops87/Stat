if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Culture]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Culture]
GO

CREATE TABLE [dbo].[Culture] (
	[CultureId] [int] IDENTITY (1, 1) NOT NULL ,
	[CultureName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


