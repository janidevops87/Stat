if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Rhythm]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Rhythm]
GO

CREATE TABLE [dbo].[Rhythm] (
	[RhythmId] [int] IDENTITY (1, 1) NOT NULL ,
	[RhythmName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


