if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spf_CreateDMVADDRTempTable]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
Begin
	PRINT 'Dropping spf_CreateDMVADDRTempTable'
	drop procedure [dbo].[spf_CreateDMVADDRTempTable]
End
GO

	PRINT 'Creating spf_CreateDMVADDRTempTable'
GO

CREATE  PROCEDURE spf_CreateDMVADDRTempTable AS

/******************************************************************************
**		File: spf_CreateDMVADDRTempTable.sql
**		Name: spf_CreateDMVADDRTempTable
**		Desc: Used to create DMVADDRTempTable
**             
**		Return values:
**
**		Called by:  
**             
**		Parameters:
**		Input							Output
**     ----------							-----------
**		None
**
**		Auth: christopher carroll
**		Date: 10/09/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			--------------------------------------
**		10/09/2007  ccarroll			initial
*******************************************************************************/

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVADDRTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVADDRTempTable]

CREATE TABLE [dbo].[DMVADDRTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[DMVID] [int] NULL ,
	[AddrTypeID] [int] NULL ,
	[Addr1] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Addr2] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[City] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[State] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Zip] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL 
) ON [PRIMARY]



GO
