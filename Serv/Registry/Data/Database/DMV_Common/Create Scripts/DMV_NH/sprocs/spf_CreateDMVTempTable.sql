 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable]
	PRINT 'Dropping Procedure: spf_CreateDMVTempTable'
END
	PRINT 'Creating Procedure: spf_CreateDMVTempTable'
GO

USE [DMV_NH]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spf_CreateDMVTempTable] AS
/******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc:  NEOB NH DMV Registry
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
**		06/02/2009	ccarroll	initial
*******************************************************************************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMVTempTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DMVTempTable]

CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogID] [int] NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
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
 	[SignupDate] [datetime] NULL,
 	[PreviousDonorState] varchar(50) NULL
) ON [PRIMARY]
