IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_PendingReferrals')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_PendingReferrals'
		DROP  Procedure  sps_rpt_PendingReferrals
	END

GO

PRINT 'Creating Procedure sps_rpt_PendingReferrals'
GO

CREATE Procedure sps_rpt_PendingReferrals
	@CallID						Int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@ReferralType				Int = Null,
	@ReportGroupID				Int = Null,
	@OrganizationID				Int = Null,
	@SourceCodeName				VarChar(10) = Null,
	@CoordinatorID				Int = Null,
	@LowerAgeLimit				Int = Null,
	@UpperAgeLimit				Int = Null,
	@Gender						VarChar(1) = Null,
	@DisplayMT					Int = Null

AS

/******************************************************************************
**		File: sps_rpt_PendingReferrals.sql
**		Name: sps_rpt_PendingReferrals
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: christopher carroll
**		Date: 08/27/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      08/30/2007		ccarroll			Initial release
**		06/11/2010		James Gerberich		Added Column for Pending Referral Type VS6249
**      09/2011			jth					added ctod and lsa dates
**		12/03/2012		James Gerberich		Archive database is being turned off, so
**											this sproc is modified to eliminate
**											the database selection
*******************************************************************************/

--DECLARE
--	@CallID						int,
--	@ReferralStartDateTime		DateTime,
--	@ReferralEndDateTime		DateTime,
--	@ReferralType				int,
--	@ReportGroupID				int,
--	@OrganizationID				int,
--	@SourceCodeName				varchar(10),
--	@CoordinatorID				int,
--	@LowerAgeLimit				int,
--	@UpperAgeLimit				int,
--	@Gender						varchar(1),
--	@DisplayMT					int

--SELECT
--	@CallID = NULL,
--	@ReferralStartDateTime = '2010-05-01 00:00:00',
--	@ReferralEndDateTime = '2010-05-15 23:59:59',
--	@ReferralType = 3,
--	@ReportGroupID = 37,
--	@OrganizationID = NULL,
--	@SourceCodeName = NULL,
--	@CoordinatorID = NULL,
--	@LowerAgeLimit = NULL,
--	@UpperAgeLimit = NULL,
--	@Gender = NULL,
--	@DisplayMT = 1

--DECLARE @Source_DB int
--SET @Source_DB = 1 /* SET database to production (default) */

	/* Search parameter configuration check
	If dates are entered with CallID value then the CallID
	value will have priority and will be searched */
IF  IsNull(@CallID, 0) <> 0
		BEGIN
			SET @ReferralStartDateTime	= Null
			SET @ReferralEndDateTime	= Null
			SET @ReferralType			= Null
			SET @SourceCodeName			= Null
			SET @CoordinatorID			= Null
			SET	@LowerAgeLimit			= Null
			SET	@UpperAgeLimit			= Null
			SET	@Gender					= Null

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

--		IF (ISNULL(@ReferralStartDateTime, GetDate()) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 1
--			END

--		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate
--			AND ISNULL(@ReferralEndDateTime, GetDate()) < @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 2
--			END

--		IF (    ISNULL(@ReferralStartDateTime, GetDate()) < @maxTableDate
--			AND ISNULL(@ReferralEndDateTime, GetDate()) > @maxTableDate
--			AND DB_NAME() NOT LIKE '%archive%')
--			BEGIN
--				SET @Source_DB = 3
--			END

--		/* Configure ReferralType search parameter. Default <Null> (or 0) will return all referral types  */
--		IF @ReferralType = 0
--			BEGIN
--				SET @ReferralType = Null
--			END
--END

CREATE TABLE #sps_rpt_PendingReferralsResults
   (
		CallID				Int NULL,
		--ReferralType		VarChar (50) NULL,
		BasedOnDT			DateTime NULL,
		ReferralFacility	VarChar (80) NULL,
		PatientName			VarChar (150) NULL,
		[A/S/R]				VarChar (50) NULL,
		PatientLastName		VarChar (50) NULL,
		PatientFirstName	VarChar (50) NULL,
		ReferralTypeID		Int NULL,
		DonorLSADeathDT		VarChar (50) NULL,
		DonorCTODDeathDT	VarChar (50) NULL,
		PendingReferralType	VarChar (5) NULL
	)

	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */
	--				INSERT #sps_rpt_PendingReferralsResults
	--					EXEC _ReferralProdArchive..sps_rpt_PendingReferrals_Select
	--						@CallID,
	--						@ReferralStartDateTIme,
	--						@ReferralEndDateTime,
	--						@ReferralType,
	--						@ReportGroupID,
	--						@OrganizationID,
	--						@SourceCodeName,
	--						@CoordinatorID,
	--						@LowerAgeLimit,
	--						@UpperAgeLimit,
	--						@Gender,
	--						@DisplayMT

	--				/* run in production database */
	--				INSERT #sps_rpt_PendingReferralsResults
	--					EXEC sps_rpt_PendingReferrals_Select
	--						@CallID,
	--						@ReferralStartDateTIme,
	--						@ReferralEndDateTime,
	--						@ReferralType,
	--						@ReportGroupID,
	--						@OrganizationID,
	--						@SourceCodeName,
	--						@CoordinatorID,
	--						@LowerAgeLimit,
	--						@UpperAgeLimit,
	--						@Gender,
	--						@DisplayMT
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */
	--				INSERT #sps_rpt_PendingReferralsResults
	--					EXEC _ReferralProdArchive..sps_rpt_PendingReferrals_Select
	--						@CallID,
	--						@ReferralStartDateTIme,
	--						@ReferralEndDateTime,
	--						@ReferralType,
	--						@ReportGroupID,
	--						@OrganizationID,
	--						@SourceCodeName,
	--						@CoordinatorID,
	--						@LowerAgeLimit,
	--						@UpperAgeLimit,
	--						@Gender,
	--						@DisplayMT
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_PendingReferralsResults
				EXEC sps_rpt_PendingReferrals_Select
							@CallID,
							@ReferralStartDateTIme,
							@ReferralEndDateTime,
							@ReferralType,
							@ReportGroupID,
							@OrganizationID,
							@SourceCodeName,
							@CoordinatorID,
							@LowerAgeLimit,
							@UpperAgeLimit,
							@Gender,
							@DisplayMT
			--END

IF
	ISNULL(@ReferralType,0) = 0
		SELECT * FROM #sps_rpt_PendingReferralsResults
ELSE
IF
	@ReferralType = 1
		SELECT * FROM #sps_rpt_PendingReferralsResults WHERE PendingReferralType LIKE 'O%'
ELSE
IF
	@ReferralType = 2
		SELECT * FROM #sps_rpt_PendingReferralsResults WHERE PendingReferralType LIKE '%T%'
ELSE
IF
	@ReferralType = 3
		SELECT * FROM #sps_rpt_PendingReferralsResults WHERE PendingReferralType LIKE '%E'

DROP TABLE #sps_rpt_PendingReferralsResults

GO