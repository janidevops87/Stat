IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVADDRTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVADDRTempTable];
	PRINT 'Dropping Procedure: spf_CreateDMVADDRTempTable';
END
PRINT 'Creating Procedure: spf_CreateDMVADDRTempTable';
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVADDRTempTable] AS
/*******************************************************************************
**		File: spf_CreateDMVADDRTempTable.sql
**		Name: spf_CreateDMVADDRTempTable
**		Desc: NV DMV Registry
**
**		Called by: 
**
**
**		Auth: Serge Hurko
**		Date: 10/18/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		10/18/2016	Serge Hurko			initial
*******************************************************************************/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[DMVADDRTempTable]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[DMVADDRTempTable];

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
) ON [PRIMARY];

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVADDRTempTable]') AND name = N'IDX_DMVADDRTempTable_DMVID_AddrTypeID')
	CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_DMVID_AddrTypeID]
	ON [dbo].[DMVADDRTempTable] ([DMVID], [AddrTypeID]) ON IDX;

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVADDRTempTable]') AND name = N'[IDX_DMVADDRTempTable_AddrTypeID_Includes]')
	CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_AddrTypeID_Includes]
	ON [dbo].[DMVADDRTempTable] ([AddrTypeID]) INCLUDE ([DMVID]) ON IDX;
GO
