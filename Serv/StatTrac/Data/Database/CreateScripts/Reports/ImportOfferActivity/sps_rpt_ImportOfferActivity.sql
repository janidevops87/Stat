IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_ImportOfferActivity]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	  PRINT 'Dropping Procedure sps_rpt_ImportOfferActivity'
	  DROP PROCEDURE [DBO].[sps_rpt_ImportOfferActivity]
  END
GO
PRINT 'Creating Procedure sps_rpt_ImportOfferActivity'
SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO

CREATE PROCEDURE sps_rpt_ImportOfferActivity
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @ImportOfferStartDateTime  DATETIME  = NULL,
                @ImportOfferEndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferActivity
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
**      10/21/08    jth                 added  MessageForOrganizationID
**		12/03/12	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */  

--  DECLARE  @CustomCode  AS INT,
--           @Results     AS INT
  
--  IF @MessageCallerOrganization IS NOT Null
--	BEGIN
--		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
--	END
--  /*Null out dates if call id is populated */
--  IF ISNULL(@CallID,0) <> 0
--    BEGIN
--      SET @ImportOfferStartDateTime = NULL
--      SET @ImportOfferEndDateTime = NULL
--      SET @MessageCallerOrganization = NULL
--      SET @MessageFor = NULL

--		/* determine if CallID is in Production db */
--		IF (SELECT Count(*) FROM CALL WHERE CALLID = @CallID) > 0
--			BEGIN /* production database */
--				SET @Source_DB = 1
--			END
--		ELSE
--			BEGIN /* Archive database */
--				SET @Source_DB = 2
--			END
--	END
--ELSE
--	BEGIN
--	/* determine if date range is in Archive db */
--	DECLARE @maxTableDate DATETIME
--	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

--		IF (ISNULL(@ImportOfferStartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 1
--			END 

--		IF (    ISNULL(@ImportOfferStartDateTime, GetDate()) < @maxTableDate 
--			AND ISNULL(@ImportOfferEndDateTime, GetDate()) < @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 2
--			END 

--		IF (    ISNULL(@ImportOfferStartDateTime, GetDate()) < @maxTableDate 
--			AND ISNULL(@ImportOfferEndDateTime, GetDate()) > @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 3
--			END 
--	END


CREATE TABLE #sps_rpt_ImportOfferActivityResults
   (
	[CallID][int] NULL, 
	[MessageTypeName][varchar] (50) NULL,
	[CallNumber][varchar] (15) NULL,
	[OrganizationName] [varchar] (80) NULL,
	[MessageCallerName][varchar] (80) NULL,
	[MessageCallerOrganization] [varchar] (80) NULL,
	[MessageCallerPhone][varchar] (20) NULL,
	[BasedOnDT1] [smalldatetime] NULL,
	[MessageForLastName] [varchar] (50) NULL,
	[PersonTypeName] [varchar] (50) NULL,
	[PersonName] [varchar] (150) NULL,
	[ReportCustomCode] [int] NULL,
	[MessageImportUNOSID][varchar] (20) NULL,
	[MessageImportCenter][varchar] (5) NULL,
	[MessageImportPatient][varchar] (50) NULL,
	[AlertGroupName][varchar] (80) NULL,
    [alertid] [int] NULL
   )

	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ImportOfferActivityResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ImportOfferActivity_Select
	--						@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT


	--				/* run in production database */
	--				INSERT #sps_rpt_ImportOfferActivityResults 
	--					EXEC sps_rpt_ImportOfferActivity_Select
	--						@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_ImportOfferActivityResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ImportOfferActivity_Select
	--						@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
	--			END

	--IF @Source_DB = 1
			--BEGIN	/* run in production database only */
			INSERT #sps_rpt_ImportOfferActivityResults 
				EXEC sps_rpt_ImportOfferActivity_Select
							@UserOrgID, @ReportGroupID, @CallID, @ImportOfferStartDateTime, @ImportOfferEndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
			--END

 
/* Display Finial Selection */ 
SELECT * FROM #sps_rpt_ImportOfferActivityResults

DROP TABLE #sps_rpt_ImportOfferActivityResults       


GO              