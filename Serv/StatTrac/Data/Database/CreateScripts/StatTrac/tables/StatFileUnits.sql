if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[StatFileUnits]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[StatFileUnits]
GO

CREATE TABLE [dbo].[StatFileUnits] (
	[UnitID] [int] IDENTITY (1, 1) NOT NULL ,
	[Units] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


