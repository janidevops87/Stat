/******************************************************************************
**		File: spf_CreateDMVTempTable.sql
**		Name: spf_CreateDMVTempTable
**		Desc: Stored Procedure: spf_CreateDMVTempTable
**
**		Auth: Moonray Schepart
**		Date: 05/28/2014 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**      05/28/2014	Moonray Schepart	initial
**		09/08/2015	mmaitan				Adding comment to force the script generator to pick up this script
*******************************************************************************/

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[spf_CreateDMVTempTable]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE [dbo].[spf_CreateDMVTempTable];
END
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  PROCEDURE spf_CreateDMVTempTable AS

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[DMVTempTable]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[DMVTempTable];

CREATE TABLE [dbo].[DMVTempTable] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[ImportLogID] [int] NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Donor] [bit] NOT NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL,
 	[FullName] [varchar] (715) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TiffFile] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[TiffDir] [tinyint] NULL ,
	[BirthMonth] [int] NULL,
	[enrollmentdate] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	branchnumber [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	PreviousDonorState varchar(50) NULL
) ON [PRIMARY]


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO