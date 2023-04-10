 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVAddrTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVAddrTempTable]
	PRINT 'Dropping Procedure: spf_CreateDMVAddrTempTable'
END
	PRINT 'Creating Procedure: spf_CreateDMVAddrTempTable'
GO

USE [DMV_NE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVAddrTempTable] AS
/******************************************************************************
**		File: spf_CreateDMVAddrTempTable.sql
**		Name: spf_CreateDMVAddrTempTable
**		Desc:  NE DMVAddr Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 10/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		10/28/2009	ccarroll	initial
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVAddrTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	drop table [dbo].[DMVAddrTempTable]
END
CREATE TABLE [dbo].[DMVAddrTempTable] (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DMVID] [int] NULL,
	[AddrTypeID] [int] NULL,
	[Addr1] [varchar](40) NULL,
	[Addr2] [varchar](20) NULL,
	[City] [varchar](25) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](10) NULL,
	[ZipExt] [varchar](4) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[CreateDate] [datetime] NULL
	) ON [PRIMARY];

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVADDRTempTable]') AND name = N'IDX_DMVADDRTempTable_DMVID_AddrTypeID')
	CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_DMVID_AddrTypeID]
	ON [dbo].[DMVADDRTempTable] ([DMVID], [AddrTypeID]) ON IDX;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVADDRTempTable]') AND name = N'[IDX_DMVADDRTempTable_AddrTypeID_Includes]')
	CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_AddrTypeID_Includes]
	ON [dbo].[DMVADDRTempTable] ([AddrTypeID]) INCLUDE ([DMVID]) ON IDX;
GO

