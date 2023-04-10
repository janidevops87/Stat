SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id (N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable];
	PRINT 'Dropping Procedure: spf_CreateDMVTempTable';
END
PRINT 'Creating Procedure: spf_CreateDMVTempTable';
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVTempTable] AS
/*******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc: NEOB RI DMV Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 06/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		06/10/2009	ccarroll	initial
**		11/28/2016		Serge Hurko			41505 - Update the database field size limits for an import file RIDONORFILE.gz
*******************************************************************************/
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DMVTempTable]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[DMVTempTable];

CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImportLogID] [int] NULL,
	[SSN] [varchar](11) NULL,
	[License] [varchar](20) NULL,
	[IssueDate] [datetime] NULL,
	[ExpirationDate] [datetime] NULL,
	[DOB] [datetime] NULL,
	[FirstName] [varchar](40) NULL,
	[MiddleName] [varchar](20) NULL,
	[LastName] [varchar](40) NULL,
	[Suffix] [varchar](4) NULL,
	[Gender] [varchar](1) NULL,
	[Donor] [bit] NOT NULL,
	[SignupDate] [datetime] NULL,
	[RenewalDate] [datetime] NULL,
	[DeceasedDate] [datetime] NULL,
	[CSORState] [varchar](2) NULL,
	[CSORLicense] [varchar](25) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[CreateDate] [datetime] NULL,
 	[PreviousDonorState] varchar(50) NULL
) ON [PRIMARY];

CREATE NONCLUSTERED INDEX [IDX_DMVTempTable_ID]
	ON [dbo].[DMVTempTable] ([ID]) ON IDX;

GO