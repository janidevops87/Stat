 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[OrganizationSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[OrganizationSelect]
	PRINT 'Dropping Procedure: OrganizationSelect'
END
	PRINT 'Creating Procedure: OrganizationSelect'
GO

CREATE PROCEDURE [dbo].[OrganizationSelect]
(
	@OrganizationId int = NULL
)
/******************************************************************************
**		File: OrganizationSelect.sql
**		Name: OrganizationSelect
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
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
**		03/31/2020	mberenson	Added New Fields: FacilityEreferralCode & EmailDomains
**		04/07/2020	mberenson	Changed Field: EmailDomains to IpWhitelist
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT     
		Organization.OrganizationID, 
		Organization.OrganizationName, 
		Organization.OrganizationAddress1, 
		Organization.OrganizationAddress2, 	
		Organization.OrganizationCity, 
		Organization.StateID, 
		State.StateAbbrv AS State, 
		Organization.OrganizationZipCode, 
		Organization.CountyID, 
		County.CountyName AS County,
		Organization.OrganizationTypeID, 
		OrganizationType.OrganizationTypeName, 		
		Organization.PhoneID, 		
		Organization.OrganizationTimeZone,
		Organization.OrganizationNotes, 
		Organization.OrganizationNoPatientName, 
		Organization.OrganizationNoRecordNum, 
		Organization.Verified, 
		Organization.Inactive, 
		COALESCE(Organization.OrganizationNoAdmitDateTime, 0) OrganizationNoAdmitDateTime, 
		COALESCE(Organization.OrganizationNoWeight, 0) OrganizationNoWeight, 
		Organization.OrganizationConfCallCust, 
		COALESCE(Organization.Unused2, 0) Unused2, 
		COALESCE(Organization.Unused3, 0) Unused3, 
		COALESCE(Organization.Unused4, 0) Unused4, 
		COALESCE(Organization.Unused5, 0) Unused5,
		COALESCE(Organization.Unused6, 0) Unused6, 
		Organization.OrganizationPageInterval, 
		Organization.LastModified, 
		COALESCE(Organization.Unused8, 0) Unused8,  
		COALESCE(Organization.OrganizationUserCode, '') OrganizationUserCode, 
		Organization.OrganizationReferralNotes, 
		Organization.OrganizationMessageNotes, 
		Organization.OrganizationConsentInterval, 
		Organization.OrganizationLO, 
		Organization.OrganizationLOEnabled, 
		Organization.OrganizationLOType, 
		Organization.OrganizationLOTriageEnabled, 
		Organization.OrganizationLOFSEnabled, 
		Organization.OrganizationArchive, 
		Organization.LastStatEmployeeID, 
		Organization.AuditLogTypeID, 
		ISNULL(Organization.ContractedStatlineClient, 0) AS ContractedStatlineClient, 
		Organization.CountryID, 
		Country.COUNTRYNAME AS Country, 
		COALESCE(Organization.ProviderNumber, '') ProviderNumber, 
		COALESCE(Organization.UnosCode, '') UnosCode, 
		Organization.OrganizationStatusId, 
		OrganizationStatus.OrganizationStatusName, 
		Organization.TimeZoneId, 
		TimeZone.TimeZoneName,
		Organization.ObservesDaylightSavings,
		Idd.IddId,
		Idd.Idd,
		CountryCode.CountryCodeId,
		CountryCode.CountryCode,
		ISNULL(StatTracOrganization, 0) AS StatTracOrganization,
		COALESCE(FacilityEreferralCode, '') AS FacilityEreferralCode
	FROM         
		Organization 
	LEFT JOIN 
		State ON Organization.StateID = State.StateID 
	LEFT JOIN 
		Country ON Organization.CountryID = Country.COUNTRYID 
	LEFT JOIN
		County ON Organization.CountyID = County.CountyID 
	LEFT JOIN 
		OrganizationStatus ON Organization.OrganizationStatusId = OrganizationStatus.OrganizationStatusID 
	LEFT JOIN 
		TimeZone ON Organization.TimeZoneId = TimeZone.TimeZoneID 
	LEFT JOIN 
		OrganizationType ON Organization.OrganizationTypeID = OrganizationType.OrganizationTypeID
	LEFT JOIN		
		Idd on Idd.IddId = Organization.IddId
	LEFT JOIN
		CountryCode ON CountryCode.CountryCodeId = Organization.CountryCodeId	
	WHERE 
			[OrganizationID] = IsNull(@OrganizationID, 0)

	RETURN @@Error
GO
