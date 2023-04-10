IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateOrganizationProperties')
	BEGIN
		PRINT 'Dropping Procedure UpdateOrganizationProperties'
		DROP  Procedure  UpdateOrganizationProperties
	END

GO

PRINT 'Creating Procedure UpdateOrganizationProperties'
GO
CREATE Procedure UpdateOrganizationProperties
    @OrganizationID int = NULL , 
    @OrganizationNoPatientName smallint = NULL , 
    @OrganizationNoRecordNum smallint = NULL , 
    @OrganizationNoAdmitDateTime smallint = NULL , 
    @OrganizationNoWeight smallint = NULL , 
    @OrganizationConfCallCust smallint = NULL , 
    @OrganizationPageInterval int = NULL , 
    @OrganizationConsentInterval int = NULL , 
    @OrganizationLO smallint = NULL , 
    @OrganizationLOType int = NULL , 
    @OrganizationLOTriageEnabled smallint = NULL , 
    @OrganizationLOFSEnabled smallint = NULL , 
    @LastStatEmployeeID int = NULL ,
    @AuditLogTypeID int = NULL	
AS

/******************************************************************************
**		File: 
**		Name: UpdateOrganizationProperties
**		Desc: Saves organization properties
**
**     ----------							-----------
**		See list
**
**		Auth: JTH
**		Date: 1/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		01/08		jth					initial 
**		08/26/2008	ccarroll			added LastModified for AuditTrail
*******************************************************************************/

UPDATE
	Organization
SET
	
	OrganizationNoPatientName = ISNULL(@OrganizationNoPatientName, OrganizationNoPatientName), 
	OrganizationNoRecordNum = ISNULL(@OrganizationNoRecordNum, OrganizationNoRecordNum), 
	OrganizationNoAdmitDateTime = ISNULL(@OrganizationNoAdmitDateTime, OrganizationNoAdmitDateTime), 
	OrganizationNoWeight = ISNULL(@OrganizationNoWeight, OrganizationNoWeight), 
	OrganizationConfCallCust = ISNULL(@OrganizationConfCallCust, OrganizationConfCallCust), 
	OrganizationPageInterval = ISNULL(@OrganizationPageInterval, OrganizationPageInterval),
	OrganizationConsentInterval = ISNULL(@OrganizationConsentInterval,OrganizationConsentInterval), 	
	OrganizationLO = ISNULL(@OrganizationLO, OrganizationLO), 
	OrganizationLOType = ISNULL(@OrganizationLOType, OrganizationLOType), 
	OrganizationLOTriageEnabled = ISNULL(@OrganizationLOTriageEnabled, OrganizationLOTriageEnabled), 
	OrganizationLOFSEnabled = ISNULL(@OrganizationLOFSEnabled, OrganizationLOFSEnabled),
	LastModified = GetDate(), 
	LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID),
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify
WHERE
	OrganizationID = @OrganizationID
GO


GRANT EXEC ON UpdateOrganization TO PUBLIC

GO
 