IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_ReferralActivity')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_ReferralActivity'
		DROP  Procedure  sps_rpt_ReferralActivity
	END

GO

PRINT 'Creating Procedure sps_rpt_ReferralActivity'
GO


CREATE Procedure sps_rpt_ReferralActivity
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
**		File: sps_rpt_ReferralActivity.sql
**		Name: sps_rpt_ReferralActivity
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
**		11/15/2007		ccarroll			Added FN for ConvertDateTime
**		06/2008 		jth					fix cardiac/referral date selection, create groupby field, 
**											remove unneeded columns,fixed join to get alert group
**		09/30/2008		ccarroll			Added selection for Archive data
**      04/2009         jth                 changed BasedOnDT to BasedOnDT1 to handle sorting in report
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


CREATE TABLE #sps_rpt_ReferralActivityResults
   (
	[CallID][int] NULL, 
	[CallNumber] [varchar] (500) NULL,
	[ReferralType] [varchar] (500) NULL,
	[AlertGroup] [varchar] (500) NULL,
	[AlertID] [int] NULL,
	[BasedOnDT1] [varchar] (500) NULL,
	[ReferralFacility] [varchar] (500) NULL,
	[ReferralPerson] [varchar] (500) NULL,
	[HospitalUnit] [varchar] (500) NULL,
	[Floor] [varchar] (500) NULL,
	[GroupBy] [varchar] (500) NULL,
	[PatientName] [varchar] (500) NULL,
	[A/S/R] [varchar] (500) NULL,
	[MedicalRecordNumber] [varchar] (500) NULL,
	[AppropriateOrgan] [varchar] (50) NULL,
	[ApproachOrgan] [varchar] (50) NULL,
	[ConsentOrgan] [varchar] (50) NULL,
	[RecoveryOrgan] [varchar] (50) NULL,
	[AppropriateBone] [varchar] (50) NULL,
	[ApproachBone] [varchar] (50) NULL,
	[ConsentBone] [varchar] (50) NULL,
	[RecoveryBone] [varchar] (50) NULL,
	[AppropriateTissue] [varchar] (50) NULL,
	[ApproachTissue] [varchar] (50) NULL,
	[ConsentTissue] [varchar] (50) NULL,
	[RecoveryTissue] [varchar] (50) NULL,
	[AppropriateSkin] [varchar] (50) NULL,
	[ApproachSkin] [varchar] (50) NULL,
	[ConsentSkin] [varchar] (50) NULL,
	[RecoverySkin] [varchar] (50) NULL,
	[AppropriateValve] [varchar] (50) NULL,
	[ApproachValve] [varchar] (50) NULL,
	[ConsentValve] [varchar] (50) NULL,
	[RecoveryValve] [varchar] (50) NULL,
	[AppropriateEyes] [varchar] (50) NULL,
	[ApproachEyes] [varchar] (50) NULL,
	[ConsentEyes] [varchar] (50) NULL,
	[RecoveryEyes] [varchar] (50) NULL,
	[AppropriateOther] [varchar] (50) NULL,
	[ApproachOther] [varchar] (50) NULL,
	[ConsentOther] [varchar] (50) NULL,
	[RecoveryOther] [varchar] (50) NULL,
	[PatientLastName] [varchar] (150) NULL,
	[PatientFirstName] [varchar] (150) NULL,
	[ReferralTypeID] [int] NULL,
	[CountOrganTissueEye] [int] NULL,
	[CountTissueEye] [int] NULL,
	[CountEyesOnly] [int] NULL,
	[CountRuleOut] [int] NULL
	)


	--IF @Source_DB = 3
	--			BEGIN /* Need to run in both archive and production databases */
	--				  /* run in Archive database */	
	--				INSERT #sps_rpt_ReferralActivityResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralActivity_Select
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
	--				INSERT #sps_rpt_ReferralActivityResults 
	--					EXEC sps_rpt_ReferralActivity_Select
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
	--				INSERT #sps_rpt_ReferralActivityResults 
	--					EXEC _ReferralProdArchive..sps_rpt_ReferralActivity_Select
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
			INSERT #sps_rpt_ReferralActivityResults 
				EXEC sps_rpt_ReferralActivity_Select
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


SELECT * FROM #sps_rpt_ReferralActivityResults

DROP TABLE #sps_rpt_ReferralActivityResults

GO

