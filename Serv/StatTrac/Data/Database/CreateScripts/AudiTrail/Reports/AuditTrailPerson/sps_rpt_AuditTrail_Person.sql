IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_AuditTrail_Person')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_AuditTrail_Person'
		DROP  Procedure  sps_rpt_AuditTrail_Person
	END

GO

PRINT 'Creating Procedure sps_rpt_AuditTrail_Person'
GO
CREATE Procedure sps_rpt_AuditTrail_Person
	@LastName varchar(50) = Null,
	@FirstName varchar(50) = Null,
	@User				int = Null, /* StatEmployee change person ID */
	@ChangeStartDateTime datetime = Null,
	@ChangeEndDateTime datetime = Null,
--	@ReportGroupID				int = Null,
--	@SourceCodeName				int = Null,
	@UserOrgID					int = Null
AS
/******************************************************************************
**		File: sps_rpt_AuditTrail_Person.sql
**		Name: sps_rpt_AuditTrail_Person
**		Desc: 
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
**		Auth: christopher carroll
**		Date: 08/08/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**      08/14/2007		ccarroll				initial
**		05/29/2008		ccarroll				Added ILB functionality
**		06/11/2008		ccarroll				Added Convert Person Name to IDs section 
**		12/03/2008		ccarroll				Added reference to vwAuditTrail
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @UserOrgTZ AS varchar(2)
DECLARE @PersonIDs AS varchar(2000)
DECLARE @Count AS int


	/* Set UserOrg Time Zone */
	SET @UserOrgTZ = (
					SELECT vwAuditTrailTimeZone.TimeZoneAbbreviation 
					FROM vwAuditTrailOrganization
					JOIN vwAuditTrailTimeZone ON vwAuditTrailOrganization.TimeZoneId = vwAuditTrailTimeZone.TimeZoneID
					WHERE OrganizationID = @UserOrgID
					)

	/* Allow wildcard search using asteric [*]  */
	IF @LastName IS NOT Null
		BEGIN
			SET @LastName = UPPER(REPLACE(@LastName,'*','%'))
		END
			
	IF @FirstName IS NOT Null
		BEGIN
			SET @FirstName = UPPER(REPLACE(@FirstName,'*','%'))
		END
 

	/* Allow wildcard search using asteric [*]  */
		IF @LastName IS NOT Null OR @FirstName IS NOT Null
			BEGIN

			/* Convert Person Name to PersonID's ' */
				DECLARE @TempPerson TABLE
					(
						ID Int IDENTITY (1,1) NOT NULL,
						PersonID 	int NULL
 					)
				  
				 INSERT @TempPerson
					SELECT DISTINCT PersonID FROM Person 
					WHERE (	Patindex(IsNull(@LastName, '~'), PersonLast) > 0 OR
							Patindex(IsNull(@FirstName, '~'), PersonFirst) > 0
						  )
					
				SET @PersonIDs = ' '
				SET @Count  = (SELECT Count(*) FROM @TempPerson)
					
				WHILE @Count > 0
					BEGIN
						SET @PersonIDs = @PersonIDs + (SELECT CAST(PersonID AS VARCHAR) FROM @TempPerson WHERE ID = @Count) 						
						SET @Count = @Count -1
					END
			END -- IF


	/* Adjust UserInputDateTime */
	SET @ChangeStartDateTime =  DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeStartDateTime) * -1), @ChangeStartDateTime)
	SET @ChangeEndDateTime = DATEADD(hh, (dbo.AuditTrailfn_TimeZoneDifference(@UserOrgTZ, @ChangeEndDateTime) * -1), @ChangeEndDateTime)


	SELECT  DISTINCT

			/* Person * - User Change Data */
			Person.LastModified AS 'ChangeDT',
			IsNull(PersonChangePerson.PersonFirst, '') + ' ' + IsNull(PersonChangePerson.PersonLast, '') AS 'ChangeUser',
			PersonChangeType.AuditLogTypeName AS 'ChangeType',

			/* Person Details */
			CASE WHEN Person.PersonID = -2 THEN 'ILB' ELSE Person.PersonID END AS 'ID',
			Person.PersonFirst AS 'FirstName',
			Person.PersonMI AS 'MI',
			Person.PersonLast AS 'LastName',
			CASE WHEN Person.PersonTypeID = -2 THEN 'ILB' ELSE  PersonRole.PersonTypeName END AS 'Role',
			CASE WHEN Person.OrganizationID = -2 THEN 'ILB' ELSE  PersonOrg.OrganizationName END AS 'Organization',	

			/* Temporary Note */
			CASE Person.PersonTempNoteActive 
					WHEN -1 THEN 'Yes' 
					WHEN 0 THEN 'No' 
					ELSE '' END AS 'TemporaryNoteActive',
			CASE WHEN Person.PersonTempNoteExpires = '01/01/1900' THEN 'ILB' 
				 ELSE Convert(varchar, Person.PersonTempNoteExpires, 101) + ' ' +
					  Convert(varchar, Person.PersonTempNoteExpires, 108) END AS 'TemporaryNoteExpires',
			Person.PersonTempNote AS 'TemporaryNote',

			/* Additional Information */
			Person.PersonNotes AS 'PermanentNote',
			CASE Person.PersonBusy 
					WHEN -1 THEN 'Yes' 
					WHEN 0 THEN 'No'
					ELSE '' END AS 'PersonBusy',
			CASE WHEN Person.PersonBusyUntil = '01/01/1900' THEN 'ILB' 
				 ELSE Convert(varchar, Person.PersonBusyUntil, 101) + ' ' +
					  Convert(varchar, Person.PersonBusyUntil, 108)END AS 'BusyUntil',

			/* Person Properties */
			CASE Person.Inactive
					WHEN 1 THEN 'Yes'
					WHEN 0 THEN 'No'
					ELSE '' END AS 'Inactive',
			CASE Person.PersonSecurity 
					WHEN -1 THEN 'Yes' 
					WHEN 0 THEN 'No' 
					ELSE '' END AS 'PersonSecurity',
			CASE Person.AllowInternetScheduleAccess 
					WHEN -1 THEN 'Yes' 
					WHEN 0 THEN 'No' 
					ELSE '' END AS 'InternetAccess',
			
			/* RS Fields included for sorting */
			PersonChangePerson.PersonLast,
			PersonChangePerson.PersonFirst

	FROM Person

	/* Person Change Lookups */
	LEFT JOIN vwAuditTrailStatEmployee PersonChangeEmployee ON PersonChangeEmployee.StatEmployeeID = Person.LastStatEmployeeID 
	LEFT JOIN vwAuditTrailPerson PersonChangePerson ON PersonChangePerson.PersonID = PersonChangeEmployee.PersonID
	LEFT JOIN vwAuditTrailAuditLogType PersonChangeType ON PersonChangeType.AuditLogTypeID = Person.AuditLogTypeID

	/* Person Detail lookups */
	LEFT JOIN vwAuditTrailPersonType PersonRole ON PersonRole.PersonTypeID = Person.PersonTypeID
	LEFT JOIN vwAuditTrailOrganization PersonOrg ON PersonOrg.OrganizationID = Person.OrganizationID

	WHERE Person.LastModified BETWEEN IsNull(@ChangeStartDateTime, Person.LastModified) AND IsNull(@ChangeEndDateTime, Person.LastModified)
		AND   PATINDEX ('%' + CAST(Person.PersonID AS Varchar) + '%' , IsNull(@PersonIDs, CAST(Person.PersonID AS Varchar))) > 0
		AND Person.LastStatEmployeeID = IsNull(@User, Person.LastStatEmployeeID)

	/* Default Sort order */
	ORDER BY
		Person.LastModified,
		PersonChangePerson.PersonLast,
		PersonChangePerson.PersonFirst,
		PersonChangeType.AuditLogTypeName




GO
