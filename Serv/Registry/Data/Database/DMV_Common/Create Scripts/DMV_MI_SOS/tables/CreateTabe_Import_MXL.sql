if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Import_XML]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	drop table [dbo].[Import_XML]
End
go


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE TABLE [Import_XML] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[name] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[address] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[city] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[state] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[zipcode] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[zipcode_extension] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[birthdate] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	CONSTRAINT [PK_IMPORT_XML] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO





SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - 1.0 table Import_XML create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 1.0 table Import_XML Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/







