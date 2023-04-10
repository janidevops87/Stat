if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSIndication]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSIndication]
GO

CREATE TABLE [dbo].[FSIndication] (
	[FSIndicationID] [int] IDENTITY (1, 1) NOT NULL ,
	[FSIndicationName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


