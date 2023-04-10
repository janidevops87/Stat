PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:4/30/2014 1:57:17 PM-- -- --  
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/ImportOfferDetail/sps_rpt_ImportOfferDetail.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/MessageDetail/sps_rpt_MessageDetail.sql

PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\ImportOfferDetail\sps_rpt_ImportOfferDetail.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ImportOfferDetail')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ImportOfferDetail'
		DROP  Procedure  sps_rpt_ImportOfferDetail
	END

GO

PRINT 'Creating Procedure sps_rpt_ImportOfferDetail'
GO

CREATE PROCEDURE [dbo].[sps_rpt_ImportOfferDetail]
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: sps_rpt_ImportOfferDetail.sql
**		Name: sps_rpt_ImportOfferDetail
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				-------------------------------------------
**		09/29/2008	ccarroll			Added selection for Archive data
**		04/02/2010	James Gerberich		Added phone extension to MessageCallerPhone
**										column. HS #22712
**		06/16/2010	Bret				Modified to Include in Release
**		12/03/12	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**		04/30/2014	Chris Carroll		Increased MessageDescription to 1000 CCRST197 wi 14835
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED;
  
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */  

/*Null out dates if call id is populated */
IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @StartDateTime = NULL;
      SET @EndDateTime = NULL;

		--/* determine if CallID is in Production db */
		--IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
		--	BEGIN /* production database */
		--		SET @Source_DB = 1
		--	END
		--ELSE
		--	BEGIN /* Archive database */
		--		SET @Source_DB = 2
		--	END
	END
--ELSE
	--BEGIN
	--/* determine if date range is in Archive db */
	--DECLARE @maxTableDate DATETIME
	--SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

	--	IF (ISNULL(@StartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 1
	--		END 

	--	IF (    ISNULL(@StartDateTime, GetDate()) < @maxTableDate 
	--		AND ISNULL(@EndDateTime, GetDate()) < @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 2
	--		END 

	--	IF (    ISNULL(@StartDateTime, GetDate()) < @maxTableDate 
	--		AND ISNULL(@EndDateTime, GetDate()) > @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 3
	--		END 
	--END


CREATE TABLE #sps_rpt_ImportOfferDetailResults
   (
	[CallID][int] NULL, 
	[MessageTypeName][varchar] (50) NULL,
	[CallNumber][varchar] (15) NULL,
	[OrganizationName] [varchar] (80) NULL,
	[MessageCallerName][varchar] (80) NULL,
	[MessageCallerOrganization] [varchar] (80) NULL,
	[MessageCallerPhone][varchar] (50) NULL,
	[CallDateTime] [smalldatetime] NULL,
	[MessageUrgent] [smallint] NULL,
	[MessageDescription] [varchar] (1000) NULL,
	[MessageForLastName] [varchar] (50) NULL,
	[PersonTypeName] [varchar] (50) NULL,
	[PersonName] [varchar] (150) NULL,
	[ReportCustomCode] [int] NULL,
	[SourceCodeName] [varchar] (50) NULL,
	[TrigageCoord] [varchar] (150) NULL,
	[MessageImportUNOSID][varchar] (20) NULL,
	[MessageImportCenter][varchar] (5) NULL,
	[MessageImportPatient][varchar] (50) NULL
   );

	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ImportOfferDetailResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ImportOfferDetail_Select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT


	--				/* run in production database */
	--				INSERT #sps_rpt_ImportOfferDetailResults 
	--					EXEC sps_rpt_ImportOfferDetail_Select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_ImportOfferDetailResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ImportOfferDetail_Select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_ImportOfferDetailResults 
				EXEC sps_rpt_ImportOfferDetail_Select
							@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT;
			--END

 
/* Display Finial Selection */ 
SELECT * FROM #sps_rpt_ImportOfferDetailResults;

DROP TABLE #sps_rpt_ImportOfferDetailResults;   



GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\MessageDetail\sps_rpt_MessageDetail.sql'
GO
IF EXISTS
	(
		SELECT	*
		FROM	DBO.SYSOBJECTS
		WHERE	ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageDetail]')
			AND OBJECTPROPERTY(ID,N'IsProcedure') = 1
	)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_MessageDetail'
		DROP PROCEDURE [DBO].[sps_rpt_MessageDetail]
	END
		PRINT 'Creating Procedure: sps_rpt_MessageDetail'
GO

SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_MessageDetail
	@UserOrgID      INT  = NULL,
	@ReportGroupID  INT  = NULL,
	@CallID         INT  = NULL,
	@StartDateTime  DATETIME  = NULL,
	@EndDateTime    DATETIME  = NULL,
	@SourceCodeName VARCHAR(50),
	@DisplayMT      INT  = NULL
AS

/******************************************************************************
**		File: sps_rpt_MessageDetail.sql
**		Name: sps_rpt_MessageDetail
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------						-----------
**
**		Auth: jth
**		Date: 5/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	-------				---------------------------------------
**		10/01/2008	ccarroll			Added selection for Archive data
**		03/15/2010	James Gerberich		Expanded MessageCallerPhone column to 
**										(VarChar(25))accomodate the extension
**										number.  HS #22712
**		06/16/2010	Bret				Modified to Include in Release
**		12/03/12	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**		04/30/2014	Chris Carroll		Increased MessageDescription to 1000 CCRST197 wi 14835
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */  

/*Null out dates if call id is populated */
IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @StartDateTime = NULL
      SET @EndDateTime = NULL

		/* determine if CallID is in Production db */
		--IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
		--	BEGIN /* production database */
		--		SET @Source_DB = 1
		--	END
		--ELSE
		--	BEGIN /* Archive database */
		--		SET @Source_DB = 2
		--	END
	END
--ELSE
	--BEGIN
	--/* determine if date range is in Archive db */
	--DECLARE @maxTableDate DATETIME
	--SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

	--	IF (ISNULL(@StartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 1
	--		END 

	--	IF (    ISNULL(@StartDateTime, GetDate()) < @maxTableDate 
	--		AND ISNULL(@EndDateTime, GetDate()) < @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 2
	--		END 

	--	IF (    ISNULL(@StartDateTime, GetDate()) < @maxTableDate 
	--		AND ISNULL(@EndDateTime, GetDate()) > @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 3
	--		END 
	--END


CREATE TABLE #sps_rpt_MessageDetailResults
   (
		[CallID][int] NULL, 
		[MessageTypeName][varchar] (50) NULL,
		[CallNumber][varchar] (15) NULL,
		[OrganizationName] [varchar] (80) NULL,
		[MessageCallerName][varchar] (80) NULL,
		[MessageCallerOrganization] [varchar] (80) NULL,
		[MessageCallerPhone][varchar] (30) NULL,
		[CallDateTime] [smalldatetime] NULL,
		[MessageUrgent] [smallint] NULL,
		[MessageDescription] [varchar] (1000) NULL,
		[MessageForLastName] [varchar] (50) NULL,
		[PersonTypeName] [varchar] (50) NULL,
		[PersonName] [varchar] (150) NULL,
		[ReportCustomCode] [int] NULL,
		[SourceCodeName] [varchar] (50) NULL,
		[TrigageCoord] [varchar] (150) NULL
   )

--IF @Source_DB = 3
--			BEGIN /* Need to run in both archive and production databases */
--				  /* run in Archive database */	
--				INSERT #sps_rpt_MessageDetailResults 
--					EXEC _ReferralProdArchive..sps_rpt_MessageDetail_Select
--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT


--				/* run in production database */
--				INSERT #sps_rpt_MessageDetailResults 
--					EXEC sps_rpt_MessageDetail_Select
--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
--			END

--IF @Source_DB = 2
--			BEGIN
--				/* run in Archive database only */	
--				INSERT #sps_rpt_MessageDetailResults 
--					EXEC _ReferralProdArchive..sps_rpt_MessageDetail_Select
--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
--			END

--IF @Source_DB = 1
--		BEGIN	/* run in production database only */
		INSERT #sps_rpt_MessageDetailResults 
			EXEC sps_rpt_MessageDetail_Select
						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
		--END


/* Display Finial Selection */ 
SELECT * FROM #sps_rpt_MessageDetailResults

DROP TABLE #sps_rpt_MessageDetailResults       


GO
GO
