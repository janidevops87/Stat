IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AgeDemographics')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AgeDemographics'
		DROP  Procedure  sps_rpt_AgeDemographics
	END

GO

PRINT 'Creating Procedure sps_rpt_AgeDemographics'

GO

CREATE Procedure sps_rpt_AgeDemographics
	(
		@ReferralStartDateTime	DateTime,
		@ReferralEndDateTime	DateTime,
		@CardiacStartDateTime	DateTime,
		@CardiacEndDateTime		DateTime,
		@AgeRange				Bit,	-- 0 = 10 years, 1 = 5 years
		@ReportGroupID			Int,
		@OrganizationID			Int,
		@SourceCodeName			VarChar(10),
		@DisplayMT				Int
	)
AS
/******************************************************************************
**		File: 
**		Name: AgeDemographics
**		Desc: Referrals broken down by Age
**
**		Called by:   Age Demographics Report
**              
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			---------------------------------------
**		12/21/09	James Gerberich		Initial design
**		12/03/12	James Gerberich		Archive database is being turned off, so
**										this sproc is modified to eliminate
**										the database selection
**		
*******************************************************************************/
----------------------------------------------------------------------------
/*
Referral Type
	1	Organ/Tissue/Eye
	2	Tissue/Eye
	3	Eyes Only
	4	Ruleout

----------------------------------------------------------------------------

Registry Status Type
	1	StateRegistry
	2	WebRegistry
	3	Not on Registry
	4	Manually Found
	5	Not Checked
*/
----------------------------------------------------------------------------
--DECLARE
--	@ReferralStartDateTime	DateTime,
--	@ReferralEndDateTime	DateTime,
--	@CardiacStartDateTime	DateTime,
--	@CardiacEndDateTime		DateTime,
--	@AgeRange				Bit,	-- 0 = 10 years, 1 = 5 years
--	@ReportGroupID			Int,
--	@OrganizationID			Int,
--	@SourceCodeName			VarChar(10),
--	@DisplayMT				Int

--SELECT
--	@ReferralStartDateTime	=	'2010-03-01 00:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2) + '-' + '01',
--	@ReferralEndDateTime	=	'2010-04-03 00:00:00', --CAST (DATEPART(yyyy,GETDATE())AS VarChar) + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(mm,GETDATE())),2)  + '-' + RIGHT('0' + CONVERT(VarChar,DATEPART(dd,GETDATE())),2)
--	@CardiacStartDateTime	=	NULL,
--	@CardiacEndDateTime		=	NULL,
--	@AgeRange				=	0, --1
--	@ReportGroupID			=	37,
--	@OrganizationID			=	NULL,
--	@SourceCodeName			=	'OROP',
--	@DisplayMT				=	0

----------------------------------------------------------------------------

--Get all of the initial data for the subsequent calculations

CREATE TABLE #Staging
	(
		ReferralFacilityID				Int,
		ReferralFacility				VarChar(80),
		PersonID						Int,
		ReferringPerson					VarChar(100),
		CallID							Int,
		ReferralDonorName				VarChar(80),
		RegistryStatus					Int,
		RegistryType					VarChar(50),
		ReferralDonorRaceId				Int,
		DonorRace						VarChar(50),
		ReferralDonorGender				VarChar(100),
		DonorAgeYears					Int,
		AgeRange						VarChar(15),
		ReferralTypeID					Int,
		ReferralTypeName				VarChar(50),
		ReferralOrganAppropriateID		Int,
		AppOrgan						VarChar(50),
		ReferralBoneAppropriateID		Int,
		AppBone							VarChar(50),
		ReferralTissueAppropriateID		Int,
		AppTissue						VarChar(50),
		ReferralSkinAppropriateID		Int,
		AppSkin							VarChar(50),
		ReferralValvesAppropriateID		Int,
		AppValves						VarChar(50),
		ReferralEyesTransAppropriateID	Int,
		AppEyes							VarChar(50),
		ReferralAllTissueDispositionID	Int,
		AppOther						VarChar(50),
		CallType						VarChar(50)
	)

----------------------------------------------------------------------------

--DECLARE
--	@Source_DB int  
--SET
--	@Source_DB = 1 /* SET database to production (default) */

------------------------------------------------------------------------------

----Determine if date range is in Archive db

--DECLARE
--	@MaxTableDate DateTime
--SELECT
--	@MaxTableDate = MAX(TableDate)
--FROM
--	ArchiveStatus

--IF
--	ISNULL(@ReferralStartDateTime,@CardiacStartDateTime) > @MaxTableDate
--AND DB_NAME() NOT LIKE '%archive%'
--		BEGIN
--			SET @Source_DB = 1
--		END 

--IF
--	ISNULL(@ReferralStartDateTime,@CardiacStartDateTime) < @MaxTableDate 
--AND ISNULL(@ReferralEndDateTime,@CardiacEndDateTime) < @maxTableDate
--AND DB_NAME() NOT LIKE '%archive%'
--		BEGIN
--			SET @Source_DB = 2
--		END 

--IF
--	ISNULL(@ReferralStartDateTime,@CardiacStartDateTime) < @MaxTableDate 
--AND	ISNULL(@ReferralEndDateTime,@CardiacEndDateTime) > @maxTableDate
--AND DB_NAME() NOT LIKE '%archive%'
--		BEGIN
--			SET @Source_DB = 3
--		END

------------------------------------------------------------------------------

--IF
--	@Source_DB = 3 /* Need to run in both archive and production databases */
--BEGIN
--	/* run in Archive database */	
--	INSERT
--		#Staging 
--	EXEC
--		_ReferralProdArchive..sps_rpt_AgeDemographics_Select
--			@ReferralStartDateTime,
--			@ReferralEndDateTime,
--			@CardiacStartDateTime,
--			@CardiacEndDateTime,
--			@AgeRange,
--			@ReportGroupID,
--			@OrganizationID,
--			@SourceCodeName,
--			@DisplayMT

--	/* run in production database */
--	INSERT
--		#Staging 
--	EXEC
--		sps_rpt_AgeDemographics_Select
--			@ReferralStartDateTime,
--			@ReferralEndDateTime,
--			@CardiacStartDateTime,
--			@CardiacEndDateTime,
--			@AgeRange,
--			@ReportGroupID,
--			@OrganizationID,
--			@SourceCodeName,
--			@DisplayMT
--END

------------------------------------------------------------------------------

--IF
--	@Source_DB = 2 /* run in Archive database only */	
--BEGIN
--	INSERT
--		#Staging 
--	EXEC _ReferralProdArchive..sps_rpt_AgeDemographics_Select
--			@ReferralStartDateTime,
--			@ReferralEndDateTime,
--			@CardiacStartDateTime,
--			@CardiacEndDateTime,
--			@AgeRange,
--			@ReportGroupID,
--			@OrganizationID,
--			@SourceCodeName,
--			@DisplayMT
--END

------------------------------------------------------------------------------

--IF
--	@Source_DB = 1 /* run in production database only */
--BEGIN
	INSERT
		#Staging 
	EXEC
		sps_rpt_AgeDemographics_Select
			@ReferralStartDateTime,
			@ReferralEndDateTime,
			@CardiacStartDateTime,
			@CardiacEndDateTime,
			@AgeRange,
			@ReportGroupID,
			@OrganizationID,
			@SourceCodeName,
			@DisplayMT
--END

----------------------------------------------------------------------------

--Temp table to hold the calculated values

CREATE TABLE #Results
	(
		SortOrder					Decimal(3,2),
		DonorGender					VarChar(100),
		AgeRange					VarChar(25),
		TotalReferrals				Int	DEFAULT 0,
		RegisteredReferrals			Int	DEFAULT 0,
		OTE							Int	DEFAULT 0,
		Tissue						Int	DEFAULT 0,
		TE							Int	DEFAULT 0,
		Eye							Int	DEFAULT 0,
		OtherEye					Int	DEFAULT 0,
		Other						Int	DEFAULT 0,
		AgeRO						Int	DEFAULT 0,
		MedRO						Int	DEFAULT 0,
		RegOTE						Int	DEFAULT 0,
		RegTissue					Int	DEFAULT 0,
		RegTE						Int	DEFAULT 0,
		RegEye						Int	DEFAULT 0,
		RegOtherEye					Int	DEFAULT 0,
		RegOther					Int	DEFAULT 0,
		RegAgeRO					Int	DEFAULT 0,
		RegMedRO					Int	DEFAULT 0,
		AgeSumTotalReferrals		Int	DEFAULT 0,
		AgeSumRegisteredReferrals	Int	DEFAULT 0,
		AgeSumOTE					Int	DEFAULT 0,
		AgeSumTissue				Int	DEFAULT 0,
		AgeSumTE					Int	DEFAULT 0,
		AgeSumEye					Int	DEFAULT 0,
		AgeSumOtherEye				Int	DEFAULT 0,
		AgeSumOther					Int	DEFAULT 0,
		AgeSumAgeRO					Int	DEFAULT 0,
		AgeSumMedRO					Int	DEFAULT 0,
		AgeSumRegOTE				Int	DEFAULT 0,
		AgeSumRegTissue				Int	DEFAULT 0,
		AgeSumRegTE					Int	DEFAULT 0,
		AgeSumRegEye				Int	DEFAULT 0,
		AgeSumRegOtherEye			Int	DEFAULT 0,
		AgeSumRegOther				Int	DEFAULT 0,
		AgeSumRegAgeRO				Int	DEFAULT 0,
		AgeSumRegMedRO				Int	DEFAULT 0
	)

----------------------------------------------------------------------------

--Begin by establishing the Age Ranges based on the what has been selected by the user

--Clasifiy the Donors into 10 year Age Ranges

IF	@AgeRange = 0
	BEGIN
		UPDATE
			#Staging
				SET
					AgeRange = 
						CASE
							WHEN DonorAgeYears BETWEEN  0 AND 10
								THEN '0-10'
							WHEN DonorAgeYears BETWEEN 11 AND 20
								THEN '11-20'
							WHEN DonorAgeYears BETWEEN 21 AND 30
								THEN '21-30'
							WHEN DonorAgeYears BETWEEN 31 AND 40
								THEN '31-40'
							WHEN DonorAgeYears BETWEEN 41 AND 50
								THEN '41-50'
							WHEN DonorAgeYears BETWEEN 51 AND 60
								THEN '51-60'
							WHEN DonorAgeYears BETWEEN 61 AND 70
								THEN '61-70'
							WHEN DonorAgeYears BETWEEN 71 AND 80
								THEN '71-80'
							WHEN DonorAgeYears >= 81
								THEN '81+'
							ELSE 'Was Not Given'
						END
				FROM
					#Staging

----------------------------------------------------------------------------

--Begin populating the table with the major categories of the report's purpose.

INSERT INTO
	#Results
		(
			SortOrder,
			DonorGender,
			AgeRange
		)
	SELECT
		1.00,
		'Female',
		'0-10'
UNION
	SELECT
		1.01,
		'Female',
		'11-20'
UNION
	SELECT
		1.02,
		'Female',
		'21-30'
UNION
	SELECT
		1.03,
		'Female',
		'31-40'
UNION
	SELECT
		1.04,
		'Female',
		'41-50'
UNION
	SELECT
		1.05,
		'Female',
		'51-60'
UNION
	SELECT
		1.06,
		'Female',
		'61-70'
UNION
	SELECT
		1.07,
		'Female',
		'71-80'
UNION
	SELECT
		1.08,
		'Female',
		'81+'
UNION
	SELECT
		1.09,
		'Female',
		'Was Not Given'
UNION
	SELECT
		2.00,
		'Male',
		'0-10'
UNION
	SELECT
		2.01,
		'Male',
		'11-20'
UNION
	SELECT
		2.02,
		'Male',
		'21-30'
UNION
	SELECT
		2.03,
		'Male',
		'31-40'
UNION
	SELECT
		2.04,
		'Male',
		'41-50'
UNION
	SELECT
		2.05,
		'Male',
		'51-60'
UNION
	SELECT
		2.06,
		'Male',
		'61-70'
UNION
	SELECT
		2.07,
		'Male',
		'71-80'
UNION
	SELECT
		2.08,
		'Male',
		'81+'
UNION
	SELECT
		2.09,
		'Male',
		'Was Not Given'
UNION
	SELECT
		3.00,
		'Was Not Given',
		'0-10'
UNION
	SELECT
		3.01,
		'Was Not Given',
		'11-20'
UNION
	SELECT
		3.02,
		'Was Not Given',
		'21-30'
UNION
	SELECT
		3.03,
		'Was Not Given',
		'31-40'
UNION
	SELECT
		3.04,
		'Was Not Given',
		'41-50'
UNION
	SELECT
		3.05,
		'Was Not Given',
		'51-60'
UNION
	SELECT
		3.06,
		'Was Not Given',
		'61-70'
UNION
	SELECT
		3.07,
		'Was Not Given',
		'71-80'
UNION
	SELECT
		3.08,
		'Was Not Given',
		'81+'
UNION
	SELECT
		3.09,
		'Was Not Given',
		'Was Not Given'
UNION
	SELECT
		4.00,
		'All (Male, Female, and Unanswered)',
		'0-10'
UNION
	SELECT
		4.01,
		'All (Male, Female, and Unanswered)',
		'11-20'
UNION
	SELECT
		4.02,
		'All (Male, Female, and Unanswered)',
		'21-30'
UNION
	SELECT
		4.03,
		'All (Male, Female, and Unanswered)',
		'31-40'
UNION
	SELECT
		4.04,
		'All (Male, Female, and Unanswered)',
		'41-50'
UNION
	SELECT
		4.05,
		'All (Male, Female, and Unanswered)',
		'51-60'
UNION
	SELECT
		4.06,
		'All (Male, Female, and Unanswered)',
		'61-70'
UNION
	SELECT
		4.07,
		'All (Male, Female, and Unanswered)',
		'71-80'
UNION
	SELECT
		4.08,
		'All (Male, Female, and Unanswered)',
		'81+'
UNION
	SELECT
		4.09,
		'All (Male, Female, and Unanswered)',
		'Was Not Given'
END

----------------------------------------------------------------------------

--Clasifiy the Donors into 5 year Age Ranges

ELSE
	BEGIN
		UPDATE
			#Staging
				SET
					AgeRange = 
						CASE
							WHEN DonorAgeYears BETWEEN  0 AND 5
								THEN '0-5'
							WHEN DonorAgeYears BETWEEN	6 AND 10
								THEN '6-10'
							WHEN DonorAgeYears BETWEEN 11 AND 15
								THEN '11-15'
							WHEN DonorAgeYears BETWEEN 16 AND 20
								THEN '16-20'
							WHEN DonorAgeYears BETWEEN 21 AND 25
								THEN '21-25'
							WHEN DonorAgeYears BETWEEN 26 AND 30
								THEN '26-30'
							WHEN DonorAgeYears BETWEEN 31 AND 35
								THEN '31-35'
							WHEN DonorAgeYears BETWEEN 36 AND 40
								THEN '36-40'
							WHEN DonorAgeYears BETWEEN 41 AND 45
								THEN '41-45'
							WHEN DonorAgeYears BETWEEN 46 AND 50
								THEN '46-50'
							WHEN DonorAgeYears BETWEEN 51 AND 55
								THEN '51-55'
							WHEN DonorAgeYears BETWEEN 56 AND 60
								THEN '56-60'
							WHEN DonorAgeYears BETWEEN 61 AND 65
								THEN '61-65'
							WHEN DonorAgeYears BETWEEN 66 AND 70
								THEN '66-70'
							WHEN DonorAgeYears BETWEEN 71 AND 75
								THEN '71-75'
							WHEN DonorAgeYears BETWEEN 76 AND 80
								THEN '76-80'
							WHEN DonorAgeYears >= 81
								THEN '81+'
							ELSE 'Was Not Given'
						END
				FROM
					#Staging

----------------------------------------------------------------------------

--Begin populating the table with the major categories of the report's purpose.

INSERT INTO
	#Results
		(
			SortOrder,
			DonorGender,
			AgeRange
		)
	SELECT
		1.00,
		'Female',
		'0-5'
UNION
	SELECT
		1.01,
		'Female',
		'6-10'
UNION
	SELECT
		1.02,
		'Female',
		'11-15'
UNION
	SELECT
		1.03,
		'Female',
		'16-20'
UNION
	SELECT
		1.04,
		'Female',
		'21-25'
UNION
	SELECT
		1.05,
		'Female',
		'26-30'
UNION
	SELECT
		1.06,
		'Female',
		'31-35'
UNION
	SELECT
		1.07,
		'Female',
		'36-40'
UNION
	SELECT
		1.08,
		'Female',
		'41-45'
UNION
	SELECT
		1.09,
		'Female',
		'46-50'
UNION
	SELECT
		1.10,
		'Female',
		'51-55'
UNION
	SELECT
		1.11,
		'Female',
		'56-60'
UNION
	SELECT
		1.12,
		'Female',
		'61-65'
UNION
	SELECT
		1.13,
		'Female',
		'66-70'
UNION
	SELECT
		1.14,
		'Female',
		'71-75'
UNION
	SELECT
		1.15,
		'Female',
		'76-80'
UNION
	SELECT
		1.16,
		'Female',
		'81+'
UNION
	SELECT
		1.17,
		'Female',
		'Was Not Given'
UNION
	SELECT
		2.00,
		'Male',
		'0-5'
UNION
	SELECT
		2.01,
		'Male',
		'6-10'
UNION
	SELECT
		2.02,
		'Male',
		'11-15'
UNION
	SELECT
		2.03,
		'Male',
		'16-20'
UNION
	SELECT
		2.04,
		'Male',
		'21-25'
UNION
	SELECT
		2.05,
		'Male',
		'26-30'
UNION
	SELECT
		2.06,
		'Male',
		'31-35'
UNION
	SELECT
		2.07,
		'Male',
		'36-40'
UNION
	SELECT
		2.08,
		'Male',
		'41-45'
UNION
	SELECT
		2.09,
		'Male',
		'46-50'
UNION
	SELECT
		2.10,
		'Male',
		'51-55'
UNION
	SELECT
		2.11,
		'Male',
		'56-60'
UNION
	SELECT
		2.12,
		'Male',
		'61-65'
UNION
	SELECT
		2.13,
		'Male',
		'66-70'
UNION
	SELECT
		2.14,
		'Male',
		'71-75'
UNION
	SELECT
		2.15,
		'Male',
		'76-80'
UNION
	SELECT
		2.16,
		'Male',
		'81+'
UNION
	SELECT
		2.17,
		'Male',
		'Was Not Given'
UNION
	SELECT
		3.00,
		'Was Not Given',
		'0-5'
UNION
	SELECT
		3.01,
		'Was Not Given',
		'6-10'
UNION
	SELECT
		3.02,
		'Was Not Given',
		'11-15'
UNION
	SELECT
		3.03,
		'Was Not Given',
		'16-20'
UNION
	SELECT
		3.04,
		'Was Not Given',
		'21-25'
UNION
	SELECT
		3.05,
		'Was Not Given',
		'26-30'
UNION
	SELECT
		3.06,
		'Was Not Given',
		'31-35'
UNION
	SELECT
		3.07,
		'Was Not Given',
		'36-40'
UNION
	SELECT
		3.08,
		'Was Not Given',
		'41-45'
UNION
	SELECT
		3.09,
		'Was Not Given',
		'46-50'
UNION
	SELECT
		3.10,
		'Was Not Given',
		'51-55'
UNION
	SELECT
		3.11,
		'Was Not Given',
		'56-60'
UNION
	SELECT
		3.12,
		'Was Not Given',
		'61-65'
UNION
	SELECT
		3.13,
		'Was Not Given',
		'66-70'
UNION
	SELECT
		3.14,
		'Was Not Given',
		'71-75'
UNION
	SELECT
		3.15,
		'Was Not Given',
		'76-80'
UNION
	SELECT
		3.16,
		'Was Not Given',
		'81+'
UNION
	SELECT
		3.17,
		'Was Not Given',
		'Was Not Given'
UNION
	SELECT
		4.00,
		'All (Male, Female, and Unanswered)',
		'0-5'
UNION
	SELECT
		4.01,
		'All (Male, Female, and Unanswered)',
		'6-10'
UNION
	SELECT
		4.02,
		'All (Male, Female, and Unanswered)',
		'11-15'
UNION
	SELECT
		4.03,
		'All (Male, Female, and Unanswered)',
		'16-20'
UNION
	SELECT
		4.04,
		'All (Male, Female, and Unanswered)',
		'21-25'
UNION
	SELECT
		4.05,
		'All (Male, Female, and Unanswered)',
		'26-30'
UNION
	SELECT
		4.06,
		'All (Male, Female, and Unanswered)',
		'31-35'
UNION
	SELECT
		4.07,
		'All (Male, Female, and Unanswered)',
		'36-40'
UNION
	SELECT
		4.08,
		'All (Male, Female, and Unanswered)',
		'41-45'
UNION
	SELECT
		4.09,
		'All (Male, Female, and Unanswered)',
		'46-50'
UNION
	SELECT
		4.10,
		'All (Male, Female, and Unanswered)',
		'51-55'
UNION
	SELECT
		4.11,
		'All (Male, Female, and Unanswered)',
		'56-60'
UNION
	SELECT
		4.12,
		'All (Male, Female, and Unanswered)',
		'61-65'
UNION
	SELECT
		4.13,
		'All (Male, Female, and Unanswered)',
		'66-70'
UNION
	SELECT
		4.14,
		'All (Male, Female, and Unanswered)',
		'71-75'
UNION
	SELECT
		4.15,
		'All (Male, Female, and Unanswered)',
		'76-80'
UNION
	SELECT
		4.16,
		'All (Male, Female, and Unanswered)',
		'81+'
UNION
	SELECT
		4.17,
		'All (Male, Female, and Unanswered)',
		'Was Not Given'
END

----------------------------------------------------------------------------

--Summary records for either Age Range

INSERT INTO
	#Results
		(
			SortOrder,
			DonorGender,
			AgeRange
		)
	SELECT
		1.90,
		'Female',
		'Total'
UNION
	SELECT
		1.91,
		'Female',
		'Average Age'
UNION
	SELECT
		2.90,
		'Male',
		'Total'
UNION
	SELECT
		2.91,
		'Male',
		'Average Age'
UNION
	SELECT
		3.90,
		'Was Not Given',
		'Total'
UNION
	SELECT
		3.91,
		'Was Not Given',
		'Average Age'
UNION
	SELECT
		4.90,
		'All (Male, Female, and Unanswered)',
		'Total'
UNION
	SELECT
		4.91,
		'All (Male, Female, and Unanswered)',
		'Average Age'

----------------------------------------------------------------------------

--Calculate the total number of Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			TotalReferrals			= x.Cnt,
			AgeSumTotalReferrals	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

--------------------------------------------------------------------------

--Calculate the number of Referrals where the Donor was a Registered Donor, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegisteredReferrals			= x.Cnt,
			AgeSumRegisteredReferrals	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.RegistryStatus IN (1,2,4)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Organ/Tissue/Eye Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			OTE			= x.Cnt,
			AgeSumOTE	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 1
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Tissue Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			Tissue			= x.Cnt,
			AgeSumTissue	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 2
				AND	
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppEyes, 'No') <> 'Yes'
					)
				AND
					(
						s.AppBone	= 'Yes'
					OR	s.AppTissue	= 'Yes'
					OR	s.AppSkin	= 'Yes'
					OR	s.AppValves	= 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

----Calculate the number of Tissue/Eye Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			TE			= x.Cnt,
			AgeSumTE	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 2
				AND	
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	s.AppEyes = 'Yes'
				AND
					(
						s.AppBone	= 'Yes'
					OR	s.AppTissue	= 'Yes'
					OR	s.AppSkin	= 'Yes'
					OR	s.AppValves	= 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Eye Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			Eye			= x.Cnt,
			AgeSumEye	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 3
				AND	
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	s.AppEyes = 'Yes'
				AND	
					(
						ISNULL(s.AppBone, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppValves, 'No') <> 'Yes'
					)
				AND
					(
						ISNULL(s.AppOther, 'No') <> 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Other/Eye Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			OtherEye		= x.Cnt,
			AgeSumOtherEye	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID IN (3,4)
				AND
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	s.AppEyes = 'Yes'
				AND	
					(
						ISNULL(s.AppBone, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppValves, 'No') <> 'Yes'
					)
				AND	s.AppOther = 'Yes'
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Other Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			Other		= x.Cnt,
			AgeSumOther	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 4
				AND
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND
					(
						ISNULL(s.AppEyes, 'No') <> 'Yes'
					)
				AND
					(
						ISNULL(s.AppBone, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppValves, 'No') <> 'Yes'
					)
				AND	s.AppOther = 'Yes'
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Age Rule Out Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			AgeRO		= x.Cnt,
			AgeSumAgeRO	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 4
				AND
					(
						ISNULL(s.AppEyes, 'No') NOT IN ('Med RO','High Risk')
					)
				AND
					(
						ISNULL(s.AppBone, 'No') NOT IN ('Med RO','High Risk')
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No') NOT IN ('Med RO','High Risk')
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') NOT IN ('Med RO','High Risk')
					)
				AND	
					(
						ISNULL(s.AppValves, 'No') NOT IN ('Med RO','High Risk')
					)
				AND
					(
						ISNULL(s.AppOther, 'No') <> 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Medical Rule Out Referrals, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			MedRO		= x.Cnt,
			AgeSumMedRO	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 4
				AND
					(
						s.AppEyes	IN ('Med RO','High Risk')
					OR	s.AppBone	IN ('Med RO','High Risk')
					OR	s.AppTissue	IN ('Med RO','High Risk')
					OR	s.AppSkin	IN ('Med RO','High Risk')
					OR	s.AppValves	IN ('Med RO','High Risk')
					)
				AND
					(
						ISNULL(s.AppOther, 'No') <> 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Organ/Tissue/Eye Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegOTE			= x.Cnt,
			AgeSumRegOTE	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 1
				AND	s.RegistryStatus IN (1,2,4)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Tissue Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegTissue		= x.Cnt,
			AgeSumRegTissue	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 2
				AND	s.RegistryStatus IN (1,2,4)
				AND	
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppEyes, 'No') <> 'Yes'
					)
				AND
					(
						s.AppBone	= 'Yes'
					OR	s.AppTissue	= 'Yes'
					OR	s.AppSkin	= 'Yes'
					OR	s.AppValves	= 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Tissue/Eye Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegTE		= x.Cnt,
			AgeSumRegTE	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 2
				AND	s.RegistryStatus IN (1,2,4)
				AND	
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	s.AppEyes = 'Yes'
				AND
					(
						s.AppBone	= 'Yes'
					OR	s.AppTissue	= 'Yes'
					OR	s.AppSkin	= 'Yes'
					OR	s.AppValves	= 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Eye Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegEye			= x.Cnt,
			AgeSumRegEye	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 3
				AND	s.RegistryStatus IN (1,2,4)
				AND	
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	s.AppEyes = 'Yes'
				AND	
					(
						ISNULL(s.AppBone, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No')	<> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppValves, 'No')	<> 'Yes'
					)
				AND
					(
						ISNULL(s.AppOther,'No')	<> 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

---------------------------------------------------------------------------

--Calculate the number of Other/Eye Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegOtherEye			= x.Cnt,
			AgeSumRegOtherEye	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID IN (3,4)
				AND	s.RegistryStatus IN (1,2,4)
				AND
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND	s.AppEyes = 'Yes'
				AND	
					(
						ISNULL(s.AppBone, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppValves, 'No') <> 'Yes'
					)
				AND	s.AppOther = 'Yes'
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Other Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegOther		= x.Cnt,
			AgeSumRegOther	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 4
				AND	s.RegistryStatus IN (1,2,4)
				AND
					(
						ISNULL(s.AppOrgan, 'No') <> 'Yes'
					)
				AND
					(
						ISNULL(s.AppEyes, 'No') <> 'Yes'
					)
				AND
					(
						ISNULL(s.AppBone, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') <> 'Yes'
					)
				AND	
					(
						ISNULL(s.AppValves, 'No') <> 'Yes'
					)
				AND	s.AppOther = 'Yes'
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Age Rule Out Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegAgeRO		= x.Cnt,
			AgeSumRegAgeRO	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 4
				AND	s.RegistryStatus IN (1,2,4)
				AND
					(
						ISNULL(s.AppEyes, 'No') NOT IN ('Med RO','High Risk')
					)
				AND
					(
						ISNULL(s.AppBone, 'No') NOT IN ('Med RO','High Risk')
					)
				AND	
					(
						ISNULL(s.AppTissue, 'No') NOT IN ('Med RO','High Risk')
					)
				AND	
					(
						ISNULL(s.AppSkin, 'No') NOT IN ('Med RO','High Risk')
					)
				AND	
					(
						ISNULL(s.AppValves, 'No') NOT IN ('Med RO','High Risk')
					)
				AND
					(
						ISNULL(s.AppOther, 'No') <> 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the number of Medical Rule Out Referrals of Registered Donors, broken down by Gender and Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			RegMedRO		= x.Cnt,
			AgeSumRegMedRO	= x.AgeSum
		FROM
			(
				SELECT
					COUNT(DISTINCT s.CallID)		AS Cnt,
					SUM(ISNULL(s.DonorAgeYears, 0))	AS AgeSum,
					s.ReferralDonorGender,
					s.AgeRange
				FROM
					#Staging s 
				WHERE
					s.ReferralTypeID = 4
				AND	s.RegistryStatus IN (1,2,4)
				AND
					(
						s.AppEyes	IN ('Med RO','High Risk')
					OR	s.AppBone	IN ('Med RO','High Risk')
					OR	s.AppTissue	IN ('Med RO','High Risk')
					OR	s.AppSkin	IN ('Med RO','High Risk')
					OR	s.AppValves	IN ('Med RO','High Risk')
					)
				AND
					(
						ISNULL(s.AppOther, 'No') <> 'Yes'
					)
				GROUP BY
					s.ReferralDonorGender,
					s.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= x.ReferralDonorGender
		AND	#Results.AgeRange		= x.AgeRange

----------------------------------------------------------------------------

--Calculate the combined number of Referrals, in each Donor category, of all Genders, broken down by Age
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			TotalReferrals				= x.TotalReferrals,
			RegisteredReferrals			= x.RegisteredReferrals,
			OTE							= x.OTE,
			Tissue						= x.Tissue,
			TE							= x.TE,
			Eye							= x.Eye,
			OtherEye					= x.OtherEye,
			Other						= x.Other,
			AgeRO						= x.AgeRO,
			MedRO						= x.MedRO,
			RegOTE						= x.RegOTE,
			RegTissue					= x.RegTissue,
			RegTE						= x.RegTE,
			RegEye						= x.RegEye,
			RegOtherEye					= x.RegOtherEye,
			RegOther					= x.RegOther,
			RegAgeRO					= x.RegAgeRO,
			RegMedRO					= x.RegMedRO,
			AgeSumTotalReferrals		= x.AgeSumTotalReferrals,
			AgeSumRegisteredReferrals	= x.AgeSumRegisteredReferrals,
			AgeSumOTE					= x.AgeSumOTE,
			AgeSumTissue				= x.AgeSumTissue,
			AgeSumTE					= x.AgeSumTE,
			AgeSumEye					= x.AgeSumEye,
			AgeSumOtherEye				= x.AgeSumOtherEye,
			AgeSumOther					= x.AgeSumOther,
			AgeSumAgeRO					= x.AgeSumAgeRO,
			AgeSumMedRO					= x.AgeSumMedRO,
			AgeSumRegOTE				= x.AgeSumRegOTE,
			AgeSumRegTissue				= x.AgeSumRegTissue,
			AgeSumRegTE					= x.AgeSumRegTE,
			AgeSumRegEye				= x.AgeSumRegEye,
			AgeSumRegOtherEye			= x.AgeSumRegOtherEye,
			AgeSumRegOther				= x.AgeSumRegOther,
			AgeSumRegAgeRO				= x.AgeSumRegAgeRO,
			AgeSumRegMedRO				= x.AgeSumRegMedRO
		FROM
			(
				SELECT
					r.AgeRange,
					SUM(TotalReferrals)				AS TotalReferrals,
					SUM(RegisteredReferrals)		AS RegisteredReferrals,
					SUM(OTE)						AS OTE,
					SUM(Tissue)						AS Tissue,
					SUM(TE)							AS TE,
					SUM(Eye)						AS Eye,
					SUM(OtherEye)					AS OtherEye,
					SUM(Other)						AS Other,
					SUM(AgeRO)						AS AgeRO,
					SUM(MedRO)						AS MedRO,
					SUM(RegOTE)						AS RegOTE,
					SUM(RegTissue)					AS RegTissue,
					SUM(RegTE)						AS RegTE,
					SUM(RegEye)						AS RegEye,
					SUM(RegOtherEye)				AS RegOtherEye,
					SUM(RegOther)					AS RegOther,
					SUM(RegAgeRO)					AS RegAgeRO,
					SUM(RegMedRO)					AS RegMedRO,
					SUM(AgeSumTotalReferrals)		AS AgeSumTotalReferrals,
					SUM(AgeSumRegisteredReferrals)	AS AgeSumRegisteredReferrals,
					SUM(AgeSumOTE)					AS AgeSumOTE,
					SUM(AgeSumTissue)				AS AgeSumTissue,
					SUM(AgeSumTE)					AS AgeSumTE,
					SUM(AgeSumEye)					AS AgeSumEye,
					SUM(AgeSumOtherEye)				AS AgeSumOtherEye,
					SUM(AgeSumOther)				AS AgeSumOther,
					SUM(AgeSumAgeRO)				AS AgeSumAgeRO,
					SUM(AgeSumMedRO)				AS AgeSumMedRO,
					SUM(AgeSumRegOTE)				AS AgeSumRegOTE,
					SUM(AgeSumRegTissue)			AS AgeSumRegTissue,
					SUM(AgeSumRegTE)				AS AgeSumRegTE,
					SUM(AgeSumRegEye)				AS AgeSumRegEye,
					SUM(AgeSumRegOtherEye)			AS AgeSumRegOtherEye,
					SUM(AgeSumRegOther)				AS AgeSumRegOther,
					SUM(AgeSumRegAgeRO)				AS AgeSumRegAgeRO,
					SUM(AgeSumRegMedRO)				AS AgeSumRegMedRO
				FROM
					#Results r
				GROUP BY
					r.AgeRange
			) AS x
		WHERE
			#Results.DonorGender	= 'All (Male, Female, and Unanswered)'
		AND	#Results.AgeRange		= x.AgeRange

--------------------------------------------------------------------------

--Calculate the combined number of Referrals, in each Donor category, of all Ages, broken down by Gender
--Also Sum the Ages for each category to use later in calculating the Average Age

UPDATE
	#Results
		SET
			TotalReferrals				= x.TotalReferrals,
			RegisteredReferrals			= x.RegisteredReferrals,
			OTE							= x.OTE,
			Tissue						= x.Tissue,
			TE							= x.TE,
			Eye							= x.Eye,
			OtherEye					= x.OtherEye,
			Other						= x.Other,
			AgeRO						= x.AgeRO,
			MedRO						= x.MedRO,
			RegOTE						= x.RegOTE,
			RegTissue					= x.RegTissue,
			RegTE						= x.RegTE,
			RegEye						= x.RegEye,
			RegOtherEye					= x.RegOtherEye,
			RegOther					= x.RegOther,
			RegAgeRO					= x.RegAgeRO,
			RegMedRO					= x.RegMedRO,
			AgeSumTotalReferrals		= x.AgeSumTotalReferrals,
			AgeSumRegisteredReferrals	= x.AgeSumRegisteredReferrals,
			AgeSumOTE					= x.AgeSumOTE,
			AgeSumTissue				= x.AgeSumTissue,
			AgeSumTE					= x.AgeSumTE,
			AgeSumEye					= x.AgeSumEye,
			AgeSumOtherEye				= x.AgeSumOtherEye,
			AgeSumOther					= x.AgeSumOther,
			AgeSumAgeRO					= x.AgeSumAgeRO,
			AgeSumMedRO					= x.AgeSumMedRO,
			AgeSumRegOTE				= x.AgeSumRegOTE,
			AgeSumRegTissue				= x.AgeSumRegTissue,
			AgeSumRegTE					= x.AgeSumRegTE,
			AgeSumRegEye				= x.AgeSumRegEye,
			AgeSumRegOtherEye			= x.AgeSumRegOtherEye,
			AgeSumRegOther				= x.AgeSumRegOther,
			AgeSumRegAgeRO				= x.AgeSumRegAgeRO,
			AgeSumRegMedRO				= x.AgeSumRegMedRO
		FROM
			(
				SELECT
					r.DonorGender,
					SUM(TotalReferrals)				AS TotalReferrals,
					SUM(RegisteredReferrals)		AS RegisteredReferrals,
					SUM(OTE)						AS OTE,
					SUM(Tissue)						AS Tissue,
					SUM(TE)							AS TE,
					SUM(Eye)						AS Eye,
					SUM(OtherEye)					AS OtherEye,
					SUM(Other)						AS Other,
					SUM(AgeRO)						AS AgeRO,
					SUM(MedRO)						AS MedRO,
					SUM(RegOTE)						AS RegOTE,
					SUM(RegTissue)					AS RegTissue,
					SUM(RegTE)						AS RegTE,
					SUM(RegEye)						AS RegEye,
					SUM(RegOtherEye)				AS RegOtherEye,
					SUM(RegOther)					AS RegOther,
					SUM(RegAgeRO)					AS RegAgeRO,
					SUM(RegMedRO)					AS RegMedRO,
					SUM(AgeSumTotalReferrals)		AS AgeSumTotalReferrals,
					SUM(AgeSumRegisteredReferrals)	AS AgeSumRegisteredReferrals,
					SUM(AgeSumOTE)					AS AgeSumOTE,
					SUM(AgeSumTissue)				AS AgeSumTissue,
					SUM(AgeSumTE)					AS AgeSumTE,
					SUM(AgeSumEye)					AS AgeSumEye,
					SUM(AgeSumOtherEye)				AS AgeSumOtherEye,
					SUM(AgeSumOther)				AS AgeSumOther,
					SUM(AgeSumAgeRO)				AS AgeSumAgeRO,
					SUM(AgeSumMedRO)				AS AgeSumMedRO,
					SUM(AgeSumRegOTE)				AS AgeSumRegOTE,
					SUM(AgeSumRegTissue)			AS AgeSumRegTissue,
					SUM(AgeSumRegTE)				AS AgeSumRegTE,
					SUM(AgeSumRegEye)				AS AgeSumRegEye,
					SUM(AgeSumRegOtherEye)			AS AgeSumRegOtherEye,
					SUM(AgeSumRegOther)				AS AgeSumRegOther,
					SUM(AgeSumRegAgeRO)				AS AgeSumRegAgeRO,
					SUM(AgeSumRegMedRO)				AS AgeSumRegMedRO
				FROM
					#Results r
				GROUP BY
					r.DonorGender
			) AS x
		WHERE
			#Results.DonorGender	= x.DonorGender
		AND	#Results.AgeRange		= 'Total'

----------------------------------------------------------------------------

--Calculate the Average Age of the donors for each category
--Null Age values in referrals would skew the Average Age, so eliminate referrals where the age was not given

DECLARE
	@CntAdjust	TABLE
		(
			DonorGender			VarChar(100),
			AgeRange			VarChar(25),
			TotalReferrals		Int	DEFAULT 0,
			RegisteredReferrals	Int	DEFAULT 0,
			OTE					Int	DEFAULT 0,
			Tissue				Int	DEFAULT 0,
			TE					Int	DEFAULT 0,
			Eye					Int	DEFAULT 0,
			OtherEye			Int	DEFAULT 0,
			Other				Int	DEFAULT 0,
			AgeRO				Int	DEFAULT 0,
			MedRO				Int	DEFAULT 0,
			RegOTE				Int	DEFAULT 0,
			RegTissue			Int	DEFAULT 0,
			RegTE				Int	DEFAULT 0,
			RegEye				Int	DEFAULT 0,
			RegOtherEye			Int	DEFAULT 0,
			RegOther			Int	DEFAULT 0,
			RegAgeRO			Int	DEFAULT 0,
			RegMedRO			Int	DEFAULT 0
		)

INSERT INTO
	@CntAdjust
		SELECT
			r1.DonorGender,
			r1.AgeRange,
			r1.TotalReferrals		- r2.TotalReferrals			AS TotalReferrals,
			r1.RegisteredReferrals	- r2.RegisteredReferrals	AS RegisteredReferrals,
			r1.OTE					- r2.OTE					AS OTE,
			r1.Tissue				- r2.Tissue					AS Tissue,
			r1.TE					- r2.TE						AS TE,
			r1.Eye					- r2.Eye					AS Eye,
			r1.OtherEye				- r2.OtherEye				AS OtherEye,
			r1.Other				- r2.Other					AS Other,
			r1.AgeRO				- r2.AgeRO					AS AgeRO,
			r1.MedRO				- r2.MedRO					AS MedRO,
			r1.RegOTE				- r2.RegOTE					AS RegOTE,
			r1.RegTissue			- r2.RegTissue				AS RegTissue,
			r1.RegTE				- r2.RegTE					AS RegTE,
			r1.RegEye				- r2.RegEye					AS RegEye,
			r1.RegOtherEye			- r2.RegOtherEye			AS RegOtherEye,
			r1.RegOther				- r2.RegOther				AS RegOther,
			r1.RegAgeRO				- r2.RegAgeRO				AS RegAgeRO,
			r1.RegMedRO				- r2.RegMedRO				AS RegMedRO
		FROM
			#Results r1
			LEFT OUTER JOIN #Results r2 ON r1.DonorGender = r2.DonorGender
		WHERE
			r1.AgeRange = 'Total'
		AND	r2.AgeRange = 'Was Not Given'

--Complete the calculation for Average Age
--The NULLIF function is used to prevent division by zero

DECLARE
	@AvgAge	TABLE
		(
			DonorGender			VarChar(100),
			AgeRange			VarChar(25),
			TotalReferrals		Int	DEFAULT 0,
			RegisteredReferrals	Int	DEFAULT 0,
			OTE					Int	DEFAULT 0,
			Tissue				Int	DEFAULT 0,
			TE					Int	DEFAULT 0,
			Eye					Int	DEFAULT 0,
			OtherEye			Int	DEFAULT 0,
			Other				Int	DEFAULT 0,
			AgeRO				Int	DEFAULT 0,
			MedRO				Int	DEFAULT 0,
			RegOTE				Int	DEFAULT 0,
			RegTissue			Int	DEFAULT 0,
			RegTE				Int	DEFAULT 0,
			RegEye				Int	DEFAULT 0,
			RegOtherEye			Int	DEFAULT 0,
			RegOther			Int	DEFAULT 0,
			RegAgeRO			Int	DEFAULT 0,
			RegMedRO			Int	DEFAULT 0
		)

INSERT INTO
	@AvgAge
		SELECT
			r.DonorGender,
			'Average Age',
			TotalReferrals		= r.AgeSumTotalReferrals	/	NULLIF(x.TotalReferrals,0),
			RegisteredReferrals	= AgeSumRegisteredReferrals	/	NULLIF(x.RegisteredReferrals,0),
			OTE					= AgeSumOTE					/	NULLIF(x.OTE,0),
			Tissue				= AgeSumTissue				/	NULLIF(x.Tissue,0),
			TE					= r.AgeSumTE				/	NULLIF(x.TE,0),
			Eye					= r.AgeSumEye				/	NULLIF(x.Eye,0),
			OtherEye			= AgeSumOtherEye			/	NULLIF(x.OtherEye,0),
			Other				= AgeSumOther				/	NULLIF(x.Other,0),
			AgeRO				= r.AgeSumAgeRO				/	NULLIF(x.AgeRO,0),
			MedRO				= r.AgeSumMedRO				/	NULLIF(x.MedRO,0),
			RegOTE				= AgeSumRegOTE				/	NULLIF(x.RegOTE,0),
			RegTissue			= AgeSumRegTissue			/	NULLIF(x.RegTissue,0),
			RegTE				= AgeSumRegTE				/	NULLIF(x.RegTE,0),
			RegEye				= AgeSumRegEye				/	NULLIF(x.RegEye,0),
			RegOtherEye			= AgeSumRegOtherEye			/	NULLIF(x.RegOtherEye,0),
			RegOther			= AgeSumRegOther			/	NULLIF(x.RegOther,0),
			RegAgeRO			= AgeSumRegAgeRO			/	NULLIF(x.RegAgeRO,0),
			RegMedRO			= AgeSumRegMedRO			/	NULLIF(x.RegMedRO,0)
		FROM
			#Results r
		LEFT OUTER JOIN @CntAdjust x ON r.DonorGender = x.DonorGender
		WHERE
			r.AgeRange = 'Total'

--Insert the Average Age into the Results table

UPDATE
	#Results
		SET
			TotalReferrals				= x.TotalReferrals,
			RegisteredReferrals			= x.RegisteredReferrals,
			OTE							= x.OTE,
			Tissue						= x.Tissue,
			TE							= x.TE,
			Eye							= x.Eye,
			OtherEye					= x.OtherEye,
			Other						= x.Other,
			AgeRO						= x.AgeRO,
			MedRO						= x.MedRO,
			RegOTE						= x.RegOTE,
			RegTissue					= x.RegTissue,
			RegTE						= x.RegTE,
			RegEye						= x.RegEye,
			RegOtherEye					= x.RegOtherEye,
			RegOther					= x.RegOther,
			RegAgeRO					= x.RegAgeRO,
			RegMedRO					= x.RegMedRO
		FROM
			@AvgAge x
		WHERE
			#Results.DonorGender	= x.DonorGender
		AND	#Results.AgeRange		= x.AgeRange

--------------------------------------------------------------------------
--Now get the final Results

SELECT 
	SortOrder,
	DonorGender,
	AgeRange,
	TotalReferrals,
	RegisteredReferrals,
	OTE,
	Tissue,
	TE,
	Eye,
	OtherEye,
	Other,
	AgeRO,
	MedRO,
	RegOTE,
	RegTissue,
	RegTE,
	RegEye,
	RegOtherEye,
	RegOther,
	RegAgeRO,
	RegMedRO
FROM
	#Results
ORDER BY
	SortOrder

------------------------------------------------------------------------

--Clean up

DROP TABLE	#Staging
DROP TABLE	#Results

GRANT EXECUTE ON sps_rpt_AgeDemographics TO PUBLIC