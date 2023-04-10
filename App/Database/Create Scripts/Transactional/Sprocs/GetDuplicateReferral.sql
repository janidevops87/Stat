IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetDuplicateReferral')
	BEGIN
		PRINT 'Dropping Procedure GetDuplicateReferral'
		PRINT GETDATE()
		DROP  Procedure  GetDuplicateReferral
	END

GO

PRINT 'Creating Procedure GetDuplicateReferral'
PRINT GETDATE()
GO
CREATE Procedure GetDuplicateReferral
	@ReferralDonorLastName	VARCHAR(40),
	@SourceCodeID			INT,
	@TimeZone				VARCHAR(2),
	@UserOrganizationID		INT, 
	@MedicalRecordNumber	NVARCHAR(30),
	@ReferralCallerOrganizationID INT,
	@CardiacDateNull		BIT
	
AS

/******************************************************************************
**		File: GetDuplicateReferral.sql
**		Name: GetDuplicateReferral
**		Desc: Queries the datbase for duplicate donor records
**
**              
**		Return values: list of duplicate referrals
** 
**		Called by:   ModStatQuery.QueryDonorName
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See List
**		Auth: Bret Knoll
**		Date: 7/3/07
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		5/20/2004	T.T					pre sproc changes added OR statement to search for null in CTOD see task # 248 *CodeReview
**		7/3/07		Bret Knoll			8.4.3.3 Performanc reduce timeouts
**		11/16/2010	Bret Knoll			Fixed code to caculate DateTimeDifference Once
**		04/19/2011	ccarroll			Fixed date selection issue in where clause
**		08/23/2011	ccarroll			Changed Duplicate Search rule to match fn def.
**										Changed SET to SELECT for performance
**		06/18/2019	mberenson			Key on ReferralDonorRecNumberSearchable to avoid invalid characters
**		03/05/2020	mberenson			Optimized for performance
**		03/19/2021	Andrey Savin		Added ReferralID to the result set, named ReferralDonorAge result column. 
*******************************************************************************/
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	DECLARE 
		@ByLastNameCardiacDateDays INT,
		@ByLastBameNoCardiacDateDays INT,
		@ByMedicalRecordNumberDays INT,
		@ByReferralFacilityDays INT,
		
		@ByLastNameCardiacDateDateTime DATETIME,
		@ByLastBameNoCardiacDateDateTime DATETIME,
		@ByMedicalRecordNumberDateTime DATETIME,
		@ByReferralFacilityDateTime DATETIME,
		@Now DATETIME = GETDATE()

	SELECT
			@ByLastNameCardiacDateDays = dbo.fn_DuplicateSearchRuleNumberOfDays(@UserOrganizationID,1, 'By Last Name with Cardiac Death d/t'),
			@ByLastBameNoCardiacDateDays = dbo.fn_DuplicateSearchRuleNumberOfDays(@UserOrganizationID,1, 'By Last Name without Cardiac Death d/t'),
			@ByMedicalRecordNumberDays = dbo.fn_DuplicateSearchRuleNumberOfDays(@UserOrganizationID,1, 'By Medical Record Number'),
			@ByReferralFacilityDays = dbo.fn_DuplicateSearchRuleNumberOfDays(@UserOrganizationID,1, 'Identity Unknown by Referral Facility'),

			@ByLastNameCardiacDateDateTime = DATEADD(d, -@ByLastNameCardiacDateDays, 
												DATEADD
													(
														hh,
														dbo.fn_TimeZoneDifference
														(
															@TimeZone, 
															GetDate()
															),
														GetDate()
													)
												),


			@ByLastBameNoCardiacDateDateTime = DATEADD(d, -@ByLastBameNoCardiacDateDays, 
													DATEADD
														(
															hh,
															dbo.fn_TimeZoneDifference
															(
																@TimeZone, 
																GetDate()
																),
															GetDate()
														)
													),


			@ByMedicalRecordNumberDateTime = DATEADD(d, -@ByMedicalRecordNumberDays, 
												DATEADD
													(
														hh,
														dbo.fn_TimeZoneDifference
														(
															@TimeZone, 
															GetDate()
															),
														GetDate()
													)
												),

			@ByReferralFacilityDateTime = DATEADD(d, -@ByReferralFacilityDays,
												DATEADD
													(
														hh,
														dbo.fn_TimeZoneDifference
														(
															@TimeZone, 
															GetDate()
															),
														GetDate()
													)
												)

	SELECT 
		Call.CallID, 
		Call.CallNumber, 
		DATEADD
			(
				hh, 
				dbo.fn_TimeZoneDifference
						(
							@TimeZone, 
							Call.CallDateTime
						),
				Call.CallDateTime
			) 'CallDateTime', 
		Referral.ReferralDonorName, 
		OrganizationName, 
		ISNULL(Referral.ReferralDonorAge,'') + ' ' + SUBSTRING(ISNULL(ReferralDonorAgeUnit,''), 1, 1) AS ReferralDonorAge, 
		Race.RaceName, 
		Referral.ReferralDonorGender, 
		ReferralDonorAdmitDate,
		ReferralID
	FROM 
		Call 
	JOIN 
		Referral ON Referral.CallID = Call.CallID 
	LEFT 
	JOIN 
		Race ON Referral.ReferralDonorRaceID = Race.RaceID 
	LEFT 
	JOIN 
		Organization ON Referral.ReferralCallerOrganizationID = Organization.OrganizationID 
	
	JOIN 
		fn_GetAspSourceCode(@SourceCodeID) AspSourceCode ON Call.SourceCodeID = AspSourceCode.AspSourceCodeID
	
	WHERE  
	-- By Last Name with Cardiac Death d/t
	(
		@ReferralDonorLastName IS NOT NULL
		AND
		Call.CallDateTime >= @ByLastNameCardiacDateDateTime AND Call.CallDateTime <= @Now
		AND
		Referral.ReferralDonorDeathDate IS NOT NULL
		AND
		Referral.ReferralDonorLastName = @ReferralDonorLastName 
	
	)
	OR
	-- By Last Name without Cardiac Death d/t
	(
		@ReferralDonorLastName IS NOT NULL
		AND
		Call.CallDateTime >=  @ByLastBameNoCardiacDateDateTime AND Call.CallDateTime <= @Now		
		AND
			Referral.ReferralDonorDeathDate IS NULL
		AND
		Referral.ReferralDonorLastName = @ReferralDonorLastName 
	
	)
	OR	
	-- By Medical Record Number2.
	(	
		@MedicalRecordNumber IS NOT NULL
		AND
		Call.CallDateTime >= @ByLastBameNoCardiacDateDateTime AND Call.CallDateTime <= @Now		
		AND
		Referral.ReferralDonorRecNumberSearchable = @MedicalRecordNumber 
		
	)
	-- OR
	---- By Identity Unknown by Referral Type

GO

GRANT EXEC ON GetDuplicateReferral TO PUBLIC

GO
