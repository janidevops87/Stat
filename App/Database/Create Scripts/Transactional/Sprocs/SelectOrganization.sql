

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SelectOrganization')
	BEGIN
		PRINT 'Dropping Procedure SelectOrganization'
		PRINT GetDate()
		DROP Procedure SelectOrganization
	END
GO

PRINT 'Creating Procedure SelectOrganization'
PRINT GetDate()
GO
CREATE Procedure SelectOrganization
(
		@OrganizationID int = null output,
		@StateID int = null,
		@CountyID int = null,
		@OrganizationTypeID int = null,
		@PhoneID int = null					
)
AS
/******************************************************************************
**	File: SelectOrganization.sql
**	Name: SelectOrganization
**	Desc: Selects multiple rows of Organization Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 12/3/2010
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	12/3/2010		Bret Knoll			Initial Sproc Creation
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		Organization.OrganizationID,
		Organization.OrganizationName,
		Organization.OrganizationAddress1,
		Organization.OrganizationAddress2,
		Organization.OrganizationCity,
		Organization.StateID,
		Organization.OrganizationZipCode,
		Organization.CountyID,
		Organization.OrganizationTypeID,
		Organization.PhoneID,
		Organization.OrganizationTimeZone,
		Organization.OrganizationNotes,
		Organization.OrganizationNoPatientName,
		Organization.OrganizationNoRecordNum,
		Organization.Verified,
		Organization.Inactive,
		Organization.OrganizationNoAdmitDateTime,
		Organization.OrganizationNoWeight,
		Organization.OrganizationConfCallCust,
		Organization.Unused2,
		Organization.Unused3,
		Organization.Unused4,
		Organization.Unused5,
		Organization.Unused6,
		Organization.OrganizationPageInterval,
		Organization.LastModified,
		Organization.Unused8,
		Organization.OrganizationUserCode,
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
		Organization.AuditLogTypeID
	FROM 
		dbo.Organization 
	WHERE 
		Organization.OrganizationID = ISNULL(@OrganizationID, Organization.OrganizationID)
	AND
		Organization.StateID = ISNULL(@StateID, Organization.StateID)
	AND
		Organization.CountyID = ISNULL(@CountyID, Organization.CountyID)
	AND
		Organization.OrganizationTypeID = ISNULL(@OrganizationTypeID, Organization.OrganizationTypeID)
	AND
		Organization.PhoneID = ISNULL(@PhoneID, Organization.PhoneID)				

GO

GRANT EXEC ON SelectOrganization TO PUBLIC
GO
