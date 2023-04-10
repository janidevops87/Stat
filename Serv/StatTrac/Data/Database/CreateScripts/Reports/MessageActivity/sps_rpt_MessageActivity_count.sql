IF EXISTS (SELECT *
           FROM   DBO.SYSOBJECTS
           WHERE  ID = OBJECT_ID(N'[dbo].[sps_rpt_MessageActivity_count]')
                  AND OBJECTPROPERTY(ID,N'IsProcedure') = 1)
  BEGIN
	DROP PROCEDURE [DBO].[SPS_RPT_MessageActivity_count]
	PRINT 'Dropping procedure: sps_rpt_MessageActivity_count'
  END
	PRINT 'Creating procedure: sps_rpt_MessageActivity_count'
GO

SET QUOTED_IDENTIFIER ON  

GO

SET ANSI_NULLS ON  

GO


CREATE PROCEDURE sps_rpt_MessageActivity_count
                @UserOrgID      INT  = NULL,
                @ReportGroupID  INT  = NULL,
                @CallID         INT  = NULL,
                @StartDateTime  DATETIME  = NULL,
                @EndDateTime    DATETIME  = NULL,
                @SourceCodeName VARCHAR(50),
                @MessageCallerOrganization VARCHAR(50),
                @MessageFor VARCHAR(50),
                @MessageForOrganizationID INT = Null,
                @DisplayMT      INT  = NULL
AS

  /******************************************************************************
**		File: 
**		Name: sps_rpt_MessageActivity_count
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
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
*******************************************************************************/
  SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED
  
DECLARE @RecordCount int
  
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

           
  IF @MessageCallerOrganization IS NOT Null
	BEGIN
		SET @MessageCallerOrganization = REPLACE(@MessageCallerOrganization,'*','%')
	END


/*Null out dates if call id is populated */
IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @StartDateTime = NULL
      SET @EndDateTime = NULL
      SET @MessageCallerOrganization = NULL
      SET @MessageFor = NULL

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


CREATE TABLE #sps_rpt_MessageActivityCountResults
   (
	[RecordCount][int] NULL 
   )

	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_MessageActivityCountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_MessageActivity_count_select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT


	--				/* run in production database */
	--				INSERT #sps_rpt_MessageActivityCountResults 
	--					EXEC sps_rpt_MessageActivity_count_select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_MessageActivityCountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_MessageActivity_count_select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_MessageActivityCountResults 
				EXEC sps_rpt_MessageActivity_count_select
							@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @MessageCallerOrganization, @MessageFor,@MessageForOrganizationID, @DisplayMT
			--END

 
/* Display Finial Selection */ 
SELECT ISNULL(SUM(RecordCount), 0) AS 'RecordCount' FROM #sps_rpt_MessageActivityCountResults

DROP TABLE #sps_rpt_MessageActivityCountResults      
       
       
GO
  