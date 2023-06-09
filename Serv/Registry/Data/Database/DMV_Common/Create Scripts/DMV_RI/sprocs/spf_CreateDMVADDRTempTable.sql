/****** Object:  StoredProcedure [dbo].[spf_CreateDMVADDRTempTable]    Script Date: 10/27/2016 6:54:44 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id (N'[dbo].[spf_CreateDMVADDRTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVADDRTempTable];
	PRINT 'Dropping Procedure: spf_CreateDMVADDRTempTable';
END
PRINT 'Creating Procedure: spf_CreateDMVADDRTempTable';
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVADDRTempTable] AS
/******************************************************************************
**		File: spf_CreateDMVADDRTempTable.sql
**		Name: spf_CreateDMVADDRTempTable
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 10/14/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**     	10/14/2008		ccarroll			Initial release
**		11/28/2016		Serge Hurko			41505 - Update the database field size limits for an import file RIDONORFILE.gz
*******************************************************************************/
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DMVADDRTempTable]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[DMVADDRTempTable];

CREATE TABLE [dbo].[DMVADDRTempTable] (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DMVID] [int] NULL,
	[AddrTypeID] [int] NULL,
	[Addr1] [varchar](80) NULL,
	[Addr2] [varchar](20) NULL,
	[City] [varchar](80) NULL,
	[State] [varchar](2) NULL,
	[Zip] [varchar](10) NULL,
	[ZipExt] [varchar](4) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_AddrTypeID_Includes]
	ON [dbo].[DMVADDRTempTable] ([AddrTypeID]) INCLUDE ([DMVID]) ON IDX;

CREATE NONCLUSTERED INDEX [IDX_DMVADDRTempTable_DMVID_AddrTypeID]
	ON [dbo].[DMVADDRTempTable] ([DMVID], [AddrTypeID]) ON IDX;

GO