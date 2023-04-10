IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Organization')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_Organization'
		DROP  Procedure  sps_rpt_AuditTrail_Organization
	END

GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Organization'
GO
CREATE Procedure sps_rpt_AuditTrail_Organization
	@OrganizationName varchar(50) = Null,
	@User int = Null,
	@ChangeStartDateTime datetime = Null,
	@ChangeEndDateTime datetime = Null,
	@UserOrgID					int = Null

AS

/******************************************************************************
**		File: sps_rpt_AuditTrail_Organization.sql
**		Name: sps_rpt_AuditTrail_Organization
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
**		Auth: Christopher Carroll
**		Date: 07/10/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      08/22/2007		ccarroll				initial release
**		05/29/2008		ccarroll				Added ILB functionality
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE	@UserOrgTZ AS varchar(2),
		@SourceCodeID AS Int,
		@OrganizationIDs AS Varchar (2000),
		@Count AS int

	/* Set UserOrg Time Zone */
	SET @UserOrgTZ = (SELECT vwAuditTrailTimeZone.TimeZoneAbbreviation 
					FROM vwAuditTrailOrganization
					JOIN vwAuditTrailTimeZone ON vwAuditTrailOrganization.TimeZoneId = vwAuditTrailTimeZone.TimeZoneID
					WHERE OrganizationID = @UserOrgID
					)

	/* Adjust UserInputDateTime */
		SET @ChangeStartDateTime =  DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeStartDateTime) * -1), @ChangeStartDateTime)
		SET @ChangeEndDateTime = DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeEndDateTime) * -1), @ChangeEndDateTime)


	/* Nullify ChangeDateTime if user did not select */
	IF @ChangeStartDateTime = @ChangeEndDateTime AND @OrganizationName Is Not Null
	BEGIN
			SET @ChangeStartDateTime = Null
			SET @ChangeEndDateTime = Null
	END

	/* Allow wildcard search using asteric [*]  */
		IF @OrganizationName IS NOT Null
			BEGIN

				SET @OrganizationName = UPPER(REPLACE(@OrganizationName,'*','%'))

				/* Convert Organization name to OrganizationID's ' */
				DECLARE @TempOrganization TABLE
					(
						ID Int IDENTITY (1,1) NOT NULL,
						OrganizationID 	int NULL
 					)
				  
				 INSERT @TempOrganization
					SELECT DISTINCT OrganizationID FROM Organization 
					WHERE Patindex(@OrganizationName, OrganizationName) > 0 
				SET @OrganizationIDs = ' '
				SET @Count  = (SELECT Count(*) FROM @TempOrganization)
					
				WHILE @Count > 0
					BEGIN
						SET @OrganizationIDs = @OrganizationIDs + (SELECT CAST(OrganizationID AS VARCHAR) FROM @TempOrganization WHERE ID = @Count) 						
						SET @Count = @Count -1
					END
			END


/* Start Select */
	SELECT

			/*** Organization *** - User Change Data */
			Organization.LastModified AS 'ChangeDT',
			IsNull(OrganizationChangePerson.PersonFirst, '') + ' ' + IsNull(OrganizationChangePerson.PersonLast, '') AS 'ChangeUser',
			OrganizationChangeType.AuditLogTypeName AS 'ChangeType',

			/* Organization Information */
			CASE WHEN Organization.OrganizationID = -2 THEN 'ILB' ELSE Organization.OrganizationID END AS 'OrganizationID',
			Organization.OrganizationName,

			/* Name and Address */
			IsNull(Organization.OrganizationAddress1, '') AS 'Address1', 
			IsNull(Organization.OrganizationAddress2, '') AS 'Address2',
			IsNull(Organization.OrganizationCity, '') AS 'City',
			CASE WHEN Organization.StateID = -2 THEN 'ILB' ELSE IsNull(stateAbb.StateAbbrv, '') END AS 'State',
			IsNull(OrganizationZipCode, '') AS 'ZipCode',
			
			/* Organization Detail */
			CASE WHEN Organization.CountyID = -2 THEN 'ILB' ELSE county.CountyName END AS 'County',
			CASE WHEN Organization.OrganizationTypeID = -2 THEN 'ILB' ELSE organizationtype.OrganizationTypeName END AS 'OrganizationType',		
			vwAuditTrailTimeZone.TimeZoneAbbreviation AS 'OrganizationTimeZone',
			CASE WHEN Organization.PhoneID = -2 THEN 'ILB' ELSE IsNull( '(' + phone.PhoneAreaCode + ') ' + phone.PhonePrefix +  '-' + phone.PhoneNumber, '') END AS 'PhoneCentral',	
			Organization.OrganizationUserCode,
			
			/* Organization Detail Continued... */
			IsNull(Organization.OrganizationNotes, '') AS 'SpecialNotes',
			CASE WHEN Organization.Verified = -1 THEN 'Yes' WHEN Organization.Verified = 0 THEN 'No' ELSE '' END AS 'Verified',
			CASE WHEN Organization.OrganizationNoPatientName = -1 THEN 'Yes' WHEN Organization.OrganizationNoPatientName = 0 THEN 'No' ELSE '' END AS 'NoPatientName',
			CASE WHEN Organization.OrganizationNoRecordNum = -1 THEN 'Yes' WHEN Organization.OrganizationNoRecordNum = 0 THEN 'No' ELSE '' END AS 'NoMedicalRec',
			CASE WHEN Organization.OrganizationConfCallCust = -1 THEN 'Yes' WHEN Organization.OrganizationConfCallCust = 0 THEN 'No' ELSE '' END AS 'ConfCallCust',
			CASE IsNull(Organization.OrganizationPageInterval, 0) WHEN -2 THEN 'ILB' WHEN 0 THEN '' ELSE CAST(Organization.OrganizationPageInterval AS varchar) END AS 'PageInterval',
			CASE IsNull(Organization.OrganizationConsentInterval, 0) WHEN -2 THEN 'ILB' WHEN 0 THEN '' ELSE CAST(Organization.OrganizationConsentInterval AS varchar) END  AS 'ConsentInterval',
			
			/* Lease Organization */
			CASE WHEN Organization.OrganizationLO = -1 THEN 'Yes' WHEN Organization.OrganizationLO = 0 THEN 'No' ELSE '' END AS 'LeaseOrg',
			CASE WHEN	(Organization.OrganizationLO = 0 AND Organization.AuditLogTypeID <> 1)
						OR(Organization.OrganizationLOType = -2)
						OR
						(
							IsNull(Organization.OrganizationLOEnabled, -1) <> 0 
							AND (Organization.OrganizationLOTriageEnabled = -1
							OR   Organization.OrganizationLOFSEnabled = -1) 
						) THEN 'No' 
				 WHEN IsNull(Organization.OrganizationLOType, -3) <> -2
						AND 
						(Organization.OrganizationLOTriageEnabled = 0
						OR	Organization.OrganizationLOFSEnabled = 0
						OR	Organization.OrganizationLOType IN(2, 4, 6)) THEN 'Yes' ELSE '' END AS 'StatlineTakingCalls',
			CASE WHEN Organization.OrganizationLOType = -2 THEN 'ILB'
				 WHEN Organization.OrganizationLOType = 2 THEN 'Triage'
				 WHEN Organization.OrganizationLOType = 4 THEN 'Family Services'
				 WHEN Organization.OrganizationLOType = 6 THEN 'Triage & FS' END AS 'LeaseOrgType',
				 
			CASE WHEN Organization.OrganizationLOType IN (-2, 4) THEN 'No'
				 WHEN Organization.OrganizationLOType IN (2, 6) THEN 'Yes'
				 ELSE '' END AS 'LeaseOrgTriageEnabled',

			CASE WHEN Organization.OrganizationLOType IN (-2, 2) THEN 'No'
				 WHEN Organization.OrganizationLOType IN (4, 6) THEN 'Yes'
				 ELSE '' END AS 'LeaseOrgFSEnabled',
				 
			/* Notes */
			IsNull(Organization.OrganizationReferralNotes, '') AS 'ReferralNotes',
			IsNull(Organization.OrganizationMessageNotes, '') AS 'MessageNotes'

	FROM Organization

	/* Organization Change Info */
	LEFT JOIN vwAuditTrailStatEmployee OrganizationChangeEmployee ON OrganizationChangeEmployee.StatEmployeeID = Organization.LastStatEmployeeID
	LEFT JOIN vwAuditTrailPerson OrganizationChangePerson ON OrganizationChangePerson.PersonID = OrganizationChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType OrganizationChangeType ON OrganizationChangeType.AuditLogTypeID = Organization.AuditLogTypeID

	LEFT JOIN vwAuditTrailState stateAbb ON StateAbb.StateID = Organization.StateID
	LEFT JOIN vwAuditTrailPhone phone ON phone.PhoneID = Organization.PhoneID
	LEFT JOIN vwAuditTrailCounty county ON county.CountyID = Organization.CountyID
	LEFT JOIN vwAuditTrailOrganizationType organizationtype ON organizationType.OrganizationTypeID = Organization.OrganizationTypeID
	LEFT JOIN vwAuditTrailTimeZone ON Organization.TimeZoneId = vwAuditTrailTimeZone.TimeZoneID
	WHERE Organization.LastModified BETWEEN IsNull(@ChangeStartDateTime, Organization.LastModified)AND IsNull(@ChangeEndDateTime, Organization.LastModified) 
	AND   PATINDEX ('%' + CAST(Organization.OrganizationID AS Varchar) + '%' , IsNull(@OrganizationIDs, CAST(Organization.OrganizationID AS Varchar))) > 0
	AND	  IsNull(Organization.LastStatEmployeeID, 0) = IsNull(@User, IsNull(Organization.LastStatEmployeeID, 0))
	

	 
GO

