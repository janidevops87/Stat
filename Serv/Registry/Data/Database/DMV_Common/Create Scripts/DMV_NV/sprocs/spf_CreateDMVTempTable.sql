IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable];
	PRINT 'Dropping Procedure: spf_CreateDMVTempTable';
END
PRINT 'Creating Procedure: spf_CreateDMVTempTable';
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVTempTable] AS
/*******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc: NV DMV Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 04/07/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/07/2010	ccarroll			initial
**		08/07/2014	Moonray Schepart	Inclusion of Display Name fields (CCRST196)
**		02/26/2016	Bret Knoll			Changed License from a 9 to 20.
*******************************************************************************/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[DMVTempTable]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[DMVTempTable];

CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogID] [int] NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Donor] [bit] NOT NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL,
	[PreviousDonorState] [varchar] (50) NULL,
	[FirstName_Display] [varchar](255) NULL,
	[MiddleName_Display] [varchar](255) NULL,
	[LastName_Display] [varchar](255) NULL,
) ON [PRIMARY];

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVTempTable]') AND name = N'IDX_DMVTempTable_ID')
	CREATE NONCLUSTERED INDEX [IDX_DMVTempTable_ID] ON [dbo].[DMVTempTable]
	(
		[ID]
	) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX];

GO
