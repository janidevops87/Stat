 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity_count')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity_Count'
		DROP  Procedure  sps_rpt_ReferralActivity_count
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity_count'
GO


CREATE Procedure sps_rpt_ReferralActivity_count
	@CallID						int = Null,
	@ReferralStartDateTime		DateTime = Null,
	@ReferralEndDateTime		DateTime = Null,
	@CardiacStartDateTime		DateTime = Null,
	@CardiacEndDateTime			DateTime = Null,
	
	@PatientFirstName			varchar(40) = Null,
	@PatientLastName			varchar(40) = Null,
	@MedicalRecordNumber		varchar(30) = Null,
	@ReferralType				int = Null,		

	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@CoordinatorID				int = Null,
	@LowerAgeLimit				int = Null,
	@UpperAgeLimit				int = Null,
	@Gender						varchar(1) = Null,

	@UserOrgID					int = Null,
	@UserID						int = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_ReferralActivity_count.sql
**		Name: sps_rpt_ReferralActivity_count
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
**		Auth: jth
**		Date: 05/08
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		09/30/2008	ccarroll			Added selection for Archive data
**		12/03/2012	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
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
			SET	@PatientFirstName		= Null
			SET @PatientLastName		= Null
			SET @MedicalRecordNumber	= Null
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
	--BEGIN
	--/* determine if date range is in Archive db */
	--DECLARE @maxTableDate DATETIME
	--SELECT @maxTableDate = MAX(TABLEDATE) FROM ARCHIVESTATUS

	--	IF (ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) > @maxTableDate AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 1
	--		END 

	--	IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
	--		AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) < @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 2
	--		END 

	--	IF (    ISNULL(@ReferralStartDateTime, @CardiacStartDateTime) < @maxTableDate 
	--		AND ISNULL(@ReferralEndDateTime, @CardiacEndDateTime) > @maxTableDate
	--		AND DB_NAME() NOT LIKE '%archive%')
	--		BEGIN
	--			SET @Source_DB = 3
	--		END 


		/* Configure ReferralType search parameter. Default <Null> (or 0) will return all referral types  */
		IF @ReferralType = 0
			BEGIN
				SET @ReferralType = Null
			END
		/* Allow wildcard search using asteric [*]  */
		IF @PatientFirstName IS NOT Null
			BEGIN
				SET @PatientFirstName = REPLACE(@PatientFirstName,'*','%')
			END
		IF @PatientLastName IS NOT Null
			BEGIN
				SET @PatientLastName = REPLACE(@PatientLastName,'*','%')
			END
		IF @MedicalRecordNumber IS NOT Null
			BEGIN
				SET @MedicalRecordNumber = REPLACE(@MedicalRecordNumber,'*','%')
			END
--END

CREATE TABLE #sps_rpt_ReferralActivity_CountResults
   (
	[RecordCount][int] NULL 
   )


	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ReferralActivity_CountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralActivity_count_select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@PatientFirstName,
	--						@PatientLastName,
	--						@MedicalRecordNumber,
	--						@ReferralType, 

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 

	--						@UserOrgID, 
	--						@UserID, 
	--						@DisplayMT 

	--				/* run in production database */
	--				INSERT #sps_rpt_ReferralActivity_CountResults 
	--					EXEC sps_rpt_ReferralActivity_count_select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@PatientFirstName,
	--						@PatientLastName,
	--						@MedicalRecordNumber,
	--						@ReferralType, 

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 

	--						@UserOrgID, 
	--						@UserID, 
	--						@DisplayMT 
	--			END

	--IF @Source_DB = 2
	--			BEGIN
	--				/* run in Archive database only */	
	--				INSERT #sps_rpt_ReferralActivity_CountResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralActivity_count_select
	--						@CallID,
	--						@ReferralStartDateTime,
	--						@ReferralEndDateTime, 
	--						@CardiacStartDateTime,
	--						@CardiacEndDateTime,

	--						@PatientFirstName,
	--						@PatientLastName,
	--						@MedicalRecordNumber,
	--						@ReferralType, 

	--						@ReportGroupID, 
	--						@OrganizationID, 
	--						@SourceCodeName, 
	--						@CoordinatorID, 
	--						@LowerAgeLimit, 
	--						@UpperAgeLimit, 
	--						@Gender, 

	--						@UserOrgID, 
	--						@UserID, 
	--						@DisplayMT 
	--			END

	--IF @Source_DB = 1
	--		BEGIN	/* run in production database only */
			INSERT #sps_rpt_ReferralActivity_CountResults 
				EXEC sps_rpt_ReferralActivity_count_select
							@CallID,
							@ReferralStartDateTime,
							@ReferralEndDateTime, 
							@CardiacStartDateTime,
							@CardiacEndDateTime,

							@PatientFirstName,
							@PatientLastName,
							@MedicalRecordNumber,
							@ReferralType, 

							@ReportGroupID, 
							@OrganizationID, 
							@SourceCodeName, 
							@CoordinatorID, 
							@LowerAgeLimit, 
							@UpperAgeLimit, 
							@Gender, 

							@UserOrgID, 
							@UserID, 
							@DisplayMT 
			--END



/* Display finial count */ 
SELECT SUM(RecordCount) AS 'RecordCount' FROM #sps_rpt_ReferralActivity_CountResults

DROP TABLE #sps_rpt_ReferralActivity_CountResults      


GO

