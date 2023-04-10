 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[OrganizationUpdate]
	PRINT 'Dropping Procedure: OrganizationUpdate'
END
	PRINT 'Creating Procedure: OrganizationUpdate'
GO

CREATE PROCEDURE [dbo].[OrganizationUpdate]
(
	@OrganizationID int = NULL OUTPUT,
	@OrganizationName varchar(80) = NULL,
	@OrganizationAddress1 varchar(80) = NULL,
	@OrganizationAddress2 varchar(80) = NULL,
	@OrganizationCity varchar(30) = NULL,
	@StateID int = NULL,
	@State varchar(50) = NULL,
	@OrganizationZipCode varchar(6) = NULL,
	@CountyID int = NULL,
	@County varchar(50) = NULL,
	@OrganizationTypeID int = NULL,
	@OrganizationTypeName varchar(50) = NULL,
	@PhoneID int = NULL,	
	@OrganizationTimeZone varchar(2) = NULL,
	@OrganizationNotes varchar(255) = NULL,
	@OrganizationNoPatientName smallint = NULL,
	@OrganizationNoRecordNum smallint = NULL,
	@Verified smallint = NULL,
	@Inactive smallint = NULL,
	@OrganizationNoAdmitDateTime smallint = NULL,
	@OrganizationNoWeight smallint = NULL,
	@OrganizationConfCallCust smallint = NULL,
	@Unused2 smallint = NULL,
	@Unused3 smallint = NULL,
	@Unused4 smallint = NULL,
	@Unused5 smallint = NULL,
	@Unused6 smallint = NULL,
	@OrganizationPageInterval int = NULL,
	@LastModified datetime = NULL,
	@Unused8 smallint = NULL,
	@OrganizationUserCode varchar(10) = NULL,
	@OrganizationReferralNotes ntext = NULL,
	@OrganizationMessageNotes ntext = NULL,
	@OrganizationConsentInterval int = NULL,
	@OrganizationLO smallint,
	@OrganizationLOEnabled smallint,
	@OrganizationLOType int = NULL,
	@OrganizationLOTriageEnabled smallint = NULL,
	@OrganizationLOFSEnabled smallint = NULL,
	@OrganizationArchive smallint = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL,
	@ContractedStatlineClient bit = NULL,
	@CountryID int = NULL,
	@Country varchar(50) = NULL,
	@ProviderNumber nvarchar(10) = NULL,
	@UnosCode nvarchar(4) = NULL,
	@OrganizationStatusId int = NULL,
	@OrganizationStatusName nvarchar(25) = NULL,
	@TimeZoneId int = NULL,
	@TimeZoneName nvarchar(25) = NULL,
	@ObservesDaylightSavings bit = NULL,
	@IddId int = NULL,
	@Idd nvarchar(10) = NULL,
	@CountryCodeId int = NULL,
	@CountryCode nvarchar(10) = NULL,
	@StatTracOrganization bit = null,
	@FacilityEreferralCode VARCHAR(20) = NULL
	
)
/******************************************************************************
**		File: OrganizationUpdate.sql
**		Name: OrganizationUpdate
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: bret
**		Date: 6/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		6/19/2009	bret		initial
**		07/12/2010	ccarroll added this note for development build (GenerateSQL)
**		03/31/2020	mberenson	Added New Fields: FacilityEreferralCode & EmailDomains
**		04/07/2020	mberenson	Changed Field: EmailDomains to IpWhitelist
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [Organization]
	SET
		OrganizationName = @OrganizationName,
		OrganizationAddress1 = @OrganizationAddress1,
		OrganizationAddress2 = @OrganizationAddress2,
		OrganizationCity = @OrganizationCity,
		StateID = @StateID,
		OrganizationZipCode = @OrganizationZipCode,
		CountyID = @CountyID,
		OrganizationTypeID = @OrganizationTypeID,
		PhoneID = @PhoneID,
		OrganizationTimeZone = @OrganizationTimeZone,
		OrganizationNotes = @OrganizationNotes,
		OrganizationNoPatientName = @OrganizationNoPatientName,
		OrganizationNoRecordNum = @OrganizationNoRecordNum,
		Verified = @Verified,
		Inactive = @Inactive,
		OrganizationNoAdmitDateTime = @OrganizationNoAdmitDateTime,
		OrganizationNoWeight = @OrganizationNoWeight,
		OrganizationConfCallCust = @OrganizationConfCallCust,
		Unused2 = @Unused2,
		Unused3 = @Unused3,
		Unused4 = @Unused4,
		Unused5 = @Unused5,
		Unused6 = @Unused6,
		OrganizationPageInterval = @OrganizationPageInterval,
		LastModified = GetDate(),
		Unused8 = @Unused8,
		OrganizationUserCode = @OrganizationUserCode,
		OrganizationReferralNotes = @OrganizationReferralNotes,
		OrganizationMessageNotes = @OrganizationMessageNotes,
		OrganizationConsentInterval = @OrganizationConsentInterval,
		OrganizationLO = @OrganizationLO,
		OrganizationLOEnabled = @OrganizationLOEnabled,
		OrganizationLOType = @OrganizationLOType,
		OrganizationLOTriageEnabled = @OrganizationLOTriageEnabled,
		OrganizationLOFSEnabled = @OrganizationLOFSEnabled,
		OrganizationArchive = @OrganizationArchive,
		LastStatEmployeeID = @LastStatEmployeeID,
		AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) /* 3 modified */,
		ContractedStatlineClient = @ContractedStatlineClient,
		CountryID = @CountryID,
		ProviderNumber = @ProviderNumber,
		UnosCode = @UnosCode,
		OrganizationStatusId = @OrganizationStatusId,
		TimeZoneId = @TimeZoneId,
		ObservesDaylightSavings = @ObservesDaylightSavings,
		IddId = @IddId,
		CountryCodeId = @CountryCodeId,
		StatTracOrganization = @StatTracOrganization,
		FacilityEreferralCode = @FacilityEreferralCode
	WHERE 
		[OrganizationID] = @OrganizationID


	RETURN @@Error
GO
