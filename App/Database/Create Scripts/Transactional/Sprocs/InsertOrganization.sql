IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertOrganization')
	BEGIN
		PRINT 'Dropping Procedure InsertOrganization'
		DROP  Procedure  InsertOrganization
	END

GO

PRINT 'Creating Procedure InsertOrganization'
GO
CREATE Procedure InsertOrganization
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
    @OrganizationReferralNotes ntext = NULL , 
    @OrganizationMessageNotes ntext = NULL , 
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
**		Name: InsertOrganization
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		@OrganizationID int, 
**		@OrganizationName varchar(80), 
**		@OrganizationAddress1 varchar(80), 
**		@OrganizationAddress2 varchar(80), 
**		@OrganizationCity varchar(30), 
**		@StateID int, 
**		@OrganizationZipCode varchar(6), 
**		@CountyID int, 
**		@OrganizationTypeID int, 
**		@PhoneID int, 
**		@OrganizationTimeZone varchar(2), 
**		@OrganizationNotes varchar(255), 
**		@OrganizationNoPatientName smallint, 
**		@OrganizationNoRecordNum smallint, 
**		@Verified smallint, 
**		@Inactive smallint, 
**		@OrganizationNoAdmitDateTime smallint, 
**		@OrganizationNoWeight smallint, 
**		@OrganizationConfCallCust smallint, 
**		@Unused2 smallint, 
**		@Unused3 smallint, 
**		@Unused4 smallint, 
**		@Unused5 smallint, 
**		@Unused6 smallint, 
**		@OrganizationPageInterval int, 
**		@Unused8 smallint, 
**		@OrganizationUserCode varchar(10), 
**		@OrganizationReferralNotes ntext, 
**		@OrganizationMessageNotes ntext, 
**		@OrganizationConsentInterval int, 
**		@OrganizationLO smallint, 
**		@OrganizationLOEnabled smallint, 
**		@OrganizationLOType int, 
**		@OrganizationLOTriageEnabled smallint, 
**		@OrganizationLOFSEnabled smallint, 
**		@OrganizationArchive smallint, 
**		@LastStatEmployeeID int
**
**		Auth: Bret Knoll
**		Date: 5/30/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      5/30/2007	Bret Knoll			8.4.3.8 AuditTrail 
*******************************************************************************/

INSERT
	Organization
	(
		OrganizationName, 
		OrganizationAddress1, 
		OrganizationAddress2, 
		OrganizationCity, 
		StateID, 
		OrganizationZipCode, 
		CountyID, 
		OrganizationTypeID, 
		PhoneID, 
		OrganizationTimeZone, 
		OrganizationNotes, 
		OrganizationNoPatientName, 
		OrganizationNoRecordNum, 
		Verified, 
		Inactive, 
		OrganizationNoAdmitDateTime, 
		OrganizationNoWeight, 
		OrganizationConfCallCust, 
		Unused2, 
		Unused3, 
		Unused4, 
		Unused5, 
		Unused6, 
		OrganizationPageInterval, 
		LastModified, 
		Unused8, 
		OrganizationUserCode, 
		OrganizationReferralNotes, 
		OrganizationMessageNotes, 
		OrganizationConsentInterval, 
		OrganizationLO,  
		OrganizationLOEnabled, 
		OrganizationLOType, 
		OrganizationLOTriageEnabled, 
		OrganizationLOFSEnabled, 
		OrganizationArchive, 
		LastStatEmployeeID, 
		AuditLogTypeID 
	
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
		GetDate(), -- @LastModified, 
		@Unused8, 
		@OrganizationUserCode, 
		@OrganizationReferralNotes, 
		@OrganizationMessageNotes, 
		@OrganizationConsentInterval, 
		ISNULL(@OrganizationLO, 0),
		ISNULL(@OrganizationLOEnabled, 0),
		@OrganizationLOType, 
		@OrganizationLOTriageEnabled, 
		@OrganizationLOFSEnabled, 
		@OrganizationArchive, 
		@LastStatEmployeeID, 
		1 -- @AuditLogTypeID  1 = Create
	
	)


SELECT
	OrganizationID, 
	OrganizationName, 
	OrganizationAddress1, 
	OrganizationAddress2, 
	OrganizationCity, 
	StateID, 
	OrganizationZipCode, 
	CountyID, 
	OrganizationTypeID, 
	PhoneID, 
	OrganizationTimeZone, 
	OrganizationNotes, 
	OrganizationNoPatientName, 
	OrganizationNoRecordNum, 
	Verified, 
	Inactive, 
	OrganizationNoAdmitDateTime, 
	OrganizationNoWeight, 
	OrganizationConfCallCust, 
	Unused2, 
	Unused3, 
	Unused4, 
	Unused5, 
	Unused6, 
	OrganizationPageInterval, 	
	Unused8, 
	OrganizationUserCode, 
	OrganizationReferralNotes, 
	OrganizationMessageNotes, 
	OrganizationConsentInterval, 
	OrganizationLO, 
	OrganizationLOEnabled, 
	OrganizationLOType, 
	OrganizationLOTriageEnabled, 
	OrganizationLOFSEnabled, 
	OrganizationArchive	
FROM
	Organization
WHERE
	OrganizationID = SCOPE_IDENTITY() 
	
GO

GRANT EXEC ON InsertOrganization TO PUBLIC

GO
