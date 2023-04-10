if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ImportOfferDetail_Count]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		drop procedure [dbo].[sps_rpt_ImportOfferDetail_Count]
		PRINT 'Dropping Procedure: sps_rpt_ImportOfferDetail_Count'
	END
PRINT 'Creating Procedure: sps_rpt_ImportOfferDetail_Count'	
GO

	
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE PROCEDURE sps_rpt_ImportOfferDetail_Count
	@UserOrgID		int = Null,
	@ReportGroupID	int = Null,
	@CallID			int = Null,
	@StartDateTime	DATETIME = NULL ,
	@EndDateTime	DATETIME = NULL,
	@SourceCodeName varchar(50) ,
	@OrganizationID int = Null,
	@DisplayMT		int = Null
	
AS

/******************************************************************************
**		File: 
**		Name: sps_rpt_ImportOfferDetail_Count
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
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
*******************************************************************************/
SET TRANSACTION ISOLATION  LEVEL  READ  UNCOMMITTED

 
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

/*Null out dates if call id is populated */
IF ISNULL(@CallID,0) <> 0
    BEGIN
      SET @StartDateTime = NULL
      SET @EndDateTime = NULL

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


CREATE TABLE #sps_rpt_ImportOfferDetailCountResults
   (
	[RecordCount][int] NULL 
   )

	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ImportOfferDetailCountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ImportOfferDetail_count_select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT


	--				/* run in production database */
	--				INSERT #sps_rpt_ImportOfferDetailCountResults 
	--					EXEC sps_rpt_ImportOfferDetail_count_select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_ImportOfferDetailCountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ImportOfferDetail_count_select
	--						@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_ImportOfferDetailCountResults 
				EXEC sps_rpt_ImportOfferDetail_count_select
							@UserOrgID, @ReportGroupID, @CallID, @StartDateTime, @EndDateTime, @SourceCodeName, @DisplayMT
			--END

 
/* Display Finial Selection */ 
SELECT SUM(RecordCount) AS 'RecordCount' FROM #sps_rpt_ImportOfferDetailCountResults

DROP TABLE #sps_rpt_ImportOfferDetailCountResults      



GO