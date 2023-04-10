if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_rpt_ReferralDetail_Count]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
		PRINT 'Dropping Procedure: sps_rpt_ReferralDetail_Count'
		DROP  Procedure  sps_rpt_ReferralDetail_Count
	END

GO

PRINT 'Creating Procedure: sps_rpt_ReferralDetail_Count'
GO


SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE PROCEDURE sps_rpt_ReferralDetail_Count
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@UserOrgID					int = Null,
	@DisplaySecondary			smallint = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralDetail_Count.sql
**		Name: sps_rpt_ReferralDetail_Count
**		Desc: 
**
**              
**		Return values:
** 
**		Called by: ReferralDetail.rdl   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: Bret Knoll  
**		Date: 04/08/2008
**
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      4/8/2008		bret				Initail release
**		09/30/2008		ccarroll			Added selection for Archive data
**		12/03/2012		James Gerberich		Archive database is being turned off, so
**											this sproc is modified to eliminate
**											the database selection
*******************************************************************************/
--DECLARE @Source_DB int  
--SET @Source_DB = 1 /* SET database to production (default) */

	/* Search parameter configuration check
	If dates are entered with CallID value then the CallID
	value will have priority and will be searched */
IF  IsNull(@CallID, 0) <> 0 
		BEGIN
			SET @ReferralStartDateTime	= Null
			SET @ReferralEndDateTime	= Null
			SET @CardiacStartDateTime	= Null
			SET @CardiacEndDateTime		= Null

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
--	BEGIN
--	/* determine if date range is in Archive db */
--	DECLARE @maxTableDate DATETIME
--	SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

--		IF (ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 1
--			END 

--		IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
--			AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) < @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 2
--			END 

--		IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
--			AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) > @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 3
--			END 

--END

CREATE TABLE #sps_rpt_ReferralDetail_CountResults
   (
	[RecordCount][int] NULL 
   )


	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ReferralDetail_CountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralDetail_count_select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 

	--						@UserOrgID, 
	--						@DisplaySecondary, 
	--						@DisplayMT 

	--				/* run in production database */
	--				INSERT #sps_rpt_ReferralDetail_CountResults 
	--					EXEC sps_rpt_ReferralDetail_count_select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 

	--						@UserOrgID, 
	--						@DisplaySecondary, 
	--						@DisplayMT 
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_ReferralDetail_CountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralDetail_count_select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 

	--						@UserOrgID, 
	--						@DisplaySecondary, 
	--						@DisplayMT 
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_ReferralDetail_CountResults 
				EXEC sps_rpt_ReferralDetail_count_select
							@CallID,
							@ReferralStartDateTime,
							@ReferralEndDateTime, 
							@CardiacStartDateTime,
							@CardiacEndDateTime,

							@ReportGroupID, 
							@OrganizationID, 
							@SourceCodeName, 
							@CoordinatorID, 
							@LowerAgeLimit, 
							@UpperAgeLimit, 
							@Gender, 

							@UserOrgID, 
							@DisplaySecondary, 
							@DisplayMT 
			--END



/* Display finial count */ 
SELECT SUM(RecordCount) AS 'RecordCount' FROM #sps_rpt_ReferralDetail_CountResults

DROP TABLE #sps_rpt_ReferralDetail_CountResults      



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

