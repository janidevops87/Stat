/* CA DMVIMPORTFILES */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVIMPORTFILES]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	PRINT 'Dropping DMVIMPORTFILES Table'
	drop table [dbo].[DMVIMPORTFILES]
End
GO

	PRINT 'Creating DMVIMPORTFILES Table'
GO

CREATE TABLE [DMVIMPORTFILES] (
	[TableName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FileName] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WorkOrder] [int] NULL ,
	CONSTRAINT [PK_DMVIMPORTFILES] PRIMARY KEY  NONCLUSTERED 
	(
		[TableName]
	) WITH  FILLFACTOR = 90  ON [PRIMARY] 
) ON [PRIMARY]
GO
