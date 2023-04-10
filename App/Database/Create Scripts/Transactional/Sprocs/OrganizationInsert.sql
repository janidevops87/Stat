 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[OrganizationInsert]
			PRINT 'Dropping Procedure: OrganizationInsert'
	END

PRINT 'Creating Procedure: OrganizationInsert'
GO

CREATE PROCEDURE [dbo].[OrganizationInsert]
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
	@StatTracOrganization bit = NULL,
	@FacilityEreferralCode VARCHAR(20) = NULL
		
)
/******************************************************************************
**		File: OrganizationInsert.sql
**		Name: OrganizationInsert
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
**		6/19/2009	bret	initial
**		07/12/2010	ccarroll	added this note for development build (GenerateSQL)
**		03/31/2020	mberenson	Added New Fields: FacilityEreferralCode & EmailDomains
**		04/07/2020	mberenson	Changed Field: EmailDomains to IpWhitelist
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [Organization]
	(
		[OrganizationName],
		[OrganizationAddress1],
		[OrganizationAddress2],
		[OrganizationCity],
		[StateID],
		[OrganizationZipCode],
		[CountyID],
		[OrganizationTypeID],
		[PhoneID],
		[OrganizationTimeZone],
		[OrganizationNotes],
		[OrganizationNoPatientName],
		[OrganizationNoRecordNum],
		[Verified],
		[Inactive],
		[OrganizationNoAdmitDateTime],
		[OrganizationNoWeight],
		[OrganizationConfCallCust],
		[Unused2],
		[Unused3],
		[Unused4],
		[Unused5],
		[Unused6],
		[OrganizationPageInterval],
		[LastModified],
		[Unused8],
		[OrganizationUserCode],
		[OrganizationReferralNotes],
		[OrganizationMessageNotes],
		[OrganizationConsentInterval],
		[OrganizationLO],
		[OrganizationLOEnabled],
		[OrganizationLOType],
		[OrganizationLOTriageEnabled],
		[OrganizationLOFSEnabled],
		[OrganizationArchive],
		[LastStatEmployeeID],
		[AuditLogTypeID],
		[ContractedStatlineClient],
		[CountryID],
		[ProviderNumber],
		[UnosCode],
		[OrganizationStatusId],
		[TimeZoneId],
		[ObservesDaylightSavings],
		[IddId],
		[CountryCodeId],
		[StatTracOrganization],		
		[FacilityEreferralCode]
		 
	)
	VALUES
	(
		@OrganizationName,
		@OrganizationAddress1,
		@OrganizationAddress2,
		@OrganizationCity,
		@StateID,
		@OrganizationZipCode,
		@CountyID,
		@OrganizationTypeID,
		@PhoneID,
		@OrganizationTimeZone,
		@OrganizationNotes,
		@OrganizationNoPatientName,
		@OrganizationNoRecordNum,
		@Verified,
		@Inactive,
		@OrganizationNoAdmitDateTime,
		@OrganizationNoWeight,
		@OrganizationConfCallCust,
		@Unused2,
		@Unused3,
		@Unused4,
		@Unused5,
		@Unused6,
		@OrganizationPageInterval,
		GETDATE(),
		@Unused8,
		@OrganizationUserCode,
		@OrganizationReferralNotes,
		@OrganizationMessageNotes,
		@OrganizationConsentInterval,
		@OrganizationLO,
		@OrganizationLOEnabled,
		@OrganizationLOType,
		@OrganizationLOTriageEnabled,
		@OrganizationLOFSEnabled,
		@OrganizationArchive,
		@LastStatEmployeeID,
		1, -- create
		@ContractedStatlineClient,
		@CountryID,
		@ProviderNumber,
		@UnosCode,
		@OrganizationStatusId,
		@TimeZoneId,
		@ObservesDaylightSavings,
		@IddId,
		@CountryCodeId,
		@StatTracOrganization,
		@FacilityEreferralCode

	)

SET @OrganizationID = SCOPE_IDENTITY()

EXEC OrganizationSelect @OrganizationID

GO
