 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable]
	PRINT 'Dropping Procedure: spf_CreateDMVTempTable'
END
	PRINT 'Creating Procedure: spf_CreateDMVTempTable'
GO

USE [DMV_NE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVTempTable] AS
/******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc:  NE DMV Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 10/28/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		10/28/2009	ccarroll			initial
**		07/31/2014	Moonray Schepart	inclusion of Display Name
**		01/16/2017	Michael Maitan		added index
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
	drop table [dbo].[DMVTempTable]
END
CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImportLogID] [int] NULL,
	[SSN] [varchar](11) NULL,
	[LicenseType] [varchar](2) NULL,
	[License] [varchar](9) NULL,
	[IssueDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[DOB] [datetime] NULL,
	[FirstName] [varchar](20) NULL,
	[MiddleName] [varchar](20) NULL,
	[LastName] [varchar](25) NULL,
	[Suffix] [varchar](4) NULL,
	[Gender] [varchar](1) NULL,
	[Donor] [bit] NOT NULL,
	[RenewalDate] [datetime] NULL,
	[DeceasedDate] [datetime] NULL,
	[CSORState] [varchar](2) NULL,
	[CSORLicense] [varchar](25) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[PreviousDonorState] [varchar](50) NULL,
	[RaceID] [int] NULL,
	[SendInfoFlag] [smallint] NULL,
	[SendInfoDate] [datetime] NULL,
	[FirstName_Display] [nvarchar](255) NULL,
	[MiddleName_Display] [nvarchar](255) NULL,
	[LastName_Display] [nvarchar](255) NULL
) ON [PRIMARY];

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DMVTempTable]') AND name = N'[IDX_DMVTempTable_ID]')
	CREATE NONCLUSTERED INDEX [IDX_DMVTempTable_ID]
	ON [dbo].[DMVTempTable] ([ID]) on IDX;
GO