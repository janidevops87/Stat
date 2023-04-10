IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'UpdateOrganization')
	BEGIN
		PRINT 'Dropping Procedure UpdateOrganization'
		DROP  Procedure  UpdateOrganization
	END

GO

PRINT 'Creating Procedure UpdateOrganization'
GO
CREATE Procedure UpdateOrganization
    @OrganizationID int = NULL , 
    @OrganizationName varchar(80) = NULL , 
    @OrganizationAddress1 varchar(80) = NULL , 
    @OrganizationAddress2 varchar(80) = NULL , 
    @OrganizationCity varchar(30) = NULL , 
    @StateID int = NULL , 
    @OrganizationZipCode varchar(6) = NULL , 
    @CountyID int = NULL , 
    @OrganizationTypeID int = NULL , 
    @PhoneID int = NULL , 
    @OrganizationTimeZone varchar(2) = NULL , 
    @OrganizationNotes varchar(255) = NULL , 
    @OrganizationNoPatientName smallint = NULL , 
    @OrganizationNoRecordNum smallint = NULL , 
    @Verified smallint = NULL , 
    @Inactive smallint = NULL , 
    @OrganizationNoAdmitDateTime smallint = NULL , 
    @OrganizationNoWeight smallint = NULL , 
    @OrganizationConfCallCust smallint = NULL , 
    @Unused2 smallint = NULL , 
    @Unused3 smallint = NULL , 
    @Unused4 smallint = NULL , 
    @Unused5 smallint = NULL , 
    @Unused6 smallint = NULL , 
    @OrganizationPageInterval int = NULL , 
    @Unused8 smallint = NULL , 
    @OrganizationUserCode varchar(10) = NULL , 
--    @OrganizationReferralNotes ntext = NULL , 
--    @OrganizationMessageNotes ntext = NULL , 
    @OrganizationConsentInterval int = NULL , 
    @OrganizationLO smallint = NULL , 
    @OrganizationLOEnabled smallint = NULL , 
    @OrganizationLOType int = NULL , 
    @OrganizationLOTriageEnabled smallint = NULL , 
    @OrganizationLOFSEnabled smallint = NULL , 
    @OrganizationArchive smallint = NULL , 
    @LastStatEmployeeID int = NULL , 
    @AuditLogTypeID int = NULL  
AS

/******************************************************************************
**		File: 
**		Name: UpdateOrganization
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
**
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See list
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
**		06/12/2008  ccarroll			Address line 2 not saving. removed isNull from parameter 
*******************************************************************************/

UPDATE
	Organization
SET
	OrganizationName = ISNULL(@OrganizationName, OrganizationName), 
	OrganizationAddress1 = ISNULL(@OrganizationAddress1, OrganizationAddress1), 
	OrganizationAddress2 = ISNULL(@OrganizationAddress2, ''), 
	OrganizationCity = ISNULL(@OrganizationCity, OrganizationCity), 
	StateID = ISNULL(@StateID, StateID), 
	OrganizationZipCode = ISNULL(@OrganizationZipCode, OrganizationZipCode),
	CountyID = ISNULL(@CountyID, CountyID),
	OrganizationTypeID = ISNULL(@OrganizationTypeID, OrganizationTypeID), 
	PhoneID = ISNULL(@PhoneID, PhoneID), 
	OrganizationTimeZone = ISNULL(@OrganizationTimeZone, OrganizationTimeZone), 
	OrganizationNotes = ISNULL(@OrganizationNotes, OrganizationNotes),  
	OrganizationNoPatientName = ISNULL(@OrganizationNoPatientName, OrganizationNoPatientName), 
	OrganizationNoRecordNum = ISNULL(@OrganizationNoRecordNum, OrganizationNoRecordNum), 
	Verified = ISNULL(@Verified, Verified), 
	Inactive = ISNULL(@Inactive, Inactive), 
	OrganizationNoAdmitDateTime = ISNULL(@OrganizationNoAdmitDateTime, OrganizationNoAdmitDateTime), 
	OrganizationNoWeight = ISNULL(@OrganizationNoWeight, OrganizationNoWeight), 
	OrganizationConfCallCust = ISNULL(@OrganizationConfCallCust, OrganizationConfCallCust), 
	Unused2 = ISNULL(@Unused2, Unused2), 
	Unused3 = ISNULL(@Unused3, Unused3), 
	Unused4 = ISNULL(@Unused4, Unused4), 
	Unused5 = ISNULL(@Unused5, Unused5), 
	Unused6 = ISNULL(@Unused6, Unused6), 
	OrganizationPageInterval = ISNULL(@OrganizationPageInterval, OrganizationPageInterval),
	LastModified = GetDate(), 
	Unused8 = ISNULL(@Unused8, Unused8), 
	OrganizationUserCode = @OrganizationUserCode, 
	OrganizationConsentInterval = ISNULL(@OrganizationConsentInterval,OrganizationConsentInterval), 	
	OrganizationLO = ISNULL(@OrganizationLO, OrganizationLO), 
	OrganizationLOEnabled = ISNULL(@OrganizationLOEnabled, OrganizationLOEnabled), 
	OrganizationLOType = ISNULL(@OrganizationLOType, OrganizationLOType), 
	OrganizationLOTriageEnabled = ISNULL(@OrganizationLOTriageEnabled, OrganizationLOTriageEnabled), 
	OrganizationLOFSEnabled = ISNULL(@OrganizationLOFSEnabled, OrganizationLOFSEnabled), 
	OrganizationArchive = ISNULL(@OrganizationArchive, OrganizationArchive), 
	LastStatEmployeeID = ISNULL(@LastStatEmployeeID, LastStatEmployeeID), 
	AuditLogTypeID = ISNULL(@AuditLogTypeID, 3) --  3 = Modify
WHERE
	OrganizationID = @OrganizationID 
	


GO

GRANT EXEC ON UpdateOrganization TO PUBLIC

GO
