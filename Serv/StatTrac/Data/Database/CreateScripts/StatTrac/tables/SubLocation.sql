if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SubLocation]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SubLocation]
GO

CREATE TABLE [dbo].[SubLocation] (
	[SubLocationID] [int] IDENTITY (1, 1) NOT NULL ,
	[SubLocationName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


