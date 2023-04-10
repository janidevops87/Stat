if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_CreateDMVADDRTempTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	drop procedure [dbo].[spf_CreateDMVADDRTempTable]
End
go


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO




CREATE  PROCEDURE spf_CreateDMVADDRTempTable AS
/*
	Procedure:	spf_CreateDMVADDRTempTable
	ISE:		christopher carroll
	Date:		1/23/2007

	Notes:		This procedure is used to create the DMVAddr temptable.

*/

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVADDRTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVADDRTempTable]

CREATE TABLE [dbo].[DMVADDRTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVID] [int] NULL ,
	[AddrTypeID] [int] NULL ,
	[Addr1] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Addr2] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/******************************* BEGIN ERROR HANDLING *********************************************/
	IF @@ERROR <> 0 
	BEGIN
	   PRINT '*** ERROR - spf_CreateDMVADDRTempTable create script failed'
	   PRINT ''
	END
	ELSE
	BEGIN
	   PRINT 'SUCCESS - 3.0 Procedure spf_CreateDMVADDRTempTable created'
	   PRINT ''
	END
	GO
/********************************* END ERROR HANDLING *********************************************/



