if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUSPENSE_A]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	drop table [dbo].[SUSPENSE_A]
End
go


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


CREATE TABLE [SUSPENSE_A] (
	[ID] [int] IDENTITY (21321, 1) NOT NULL ,
	[IMPORTLOGID] [int] NULL ,
	[LAST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FIRST] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MIDDLE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SUFFIX] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ACITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ASTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[AZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BADDR1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BCITY] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BZIP] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[GENDER] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DONOR] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RENEWALDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DECEASEDDATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORSTATE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLICENSE] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FULLNAME] [varchar] (715) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OK] [bit] NOT NULL ,
	[REASON] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - 1.0 table SUSPENSE_A create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 1.0 table SUSPENSE_A Created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/







