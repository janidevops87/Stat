 /***************************************************************************************************
**	Name: Organization
**	Desc: Remove and correct malformed records 
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
PRINT 'Cleaning up Data'
 if exists (select * from Organization where isnull(Organization.OrganizationTypeID, 0) = 0)
begin
	PRINT 'UPDATE OrganizationTypeID'
	update Organization 
	set OrganizationTypeID = 10,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	where isnull(Organization.OrganizationTypeID, 0) = 0
	and OrganizationName like '%Hospital%'

	update Organization 
	set OrganizationTypeID = 30,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	where isnull(Organization.OrganizationTypeID, 0) = 0
	and (OrganizationName like '%Precinct%'
	or OrganizationName like '%Precient%'
	or OrganizationName like '%Precint%')
	
	update Organization 
	set OrganizationTypeID = 3,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	where isnull(Organization.OrganizationTypeID, 0) = 0
	and OrganizationName like '%Examiner%'

	delete Organization where isnull(Organization.OrganizationTypeID, 0) = 0
	and len(OrganizationName) = 0
end
IF EXISTS (SELECT * FROM Organization WHERE Inactive IS NULL)
BEGIN
	PRINT 'UPDATE Organization.Inactive'
	UPDATE Organization 
	SET Inactive = 0,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Inactive IS NULL
END


-- 2 'Active / Verified'
-- SELECT * FROM Organization where Organization.Inactive = 0 and Organization.Verified in (-1, 1)
	PRINT 'Organization.OrganizationStatusId'
	UPDATE Organization
	SET Organization.OrganizationStatusId = 2,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.OrganizationStatusId IS NULL
	AND Organization.Inactive = 0 
	AND Organization.Verified in (-1, 1)

-- 1, 'Active / Not Verified'
-- SELECT * FROM Organization where Organization.Inactive = 0 and Organization.Verified in (0)
	UPDATE Organization
	SET Organization.OrganizationStatusId = 1,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.OrganizationStatusId IS NULL
	AND Organization.Inactive = 0 
	AND Organization.Verified in (0)

-- 3, 'InActive 
-- SELECT * FROM Organization where Organization.Inactive IN (1, -1)
	UPDATE Organization
	SET Organization.OrganizationStatusId = 1,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.OrganizationStatusId IS NULL
	


	PRINT 'Updating Organization.CountryId'
	UPDATE Organization
	SET CountryId = 1,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE CountryId IS NULL
	AND StateID NOT IN (52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63) 


	UPDATE Organization
	SET CountryId = 178,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE CountryId IS NULL
	AND StateID IN (55) 

	UPDATE Organization
	SET CountryId = 24,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE CountryId IS NULL
	AND StateID IN (52) 

	UPDATE Organization
	SET CountryId = 38,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE CountryId IS NULL


	PRINT 'Updating Organization.TimeZoneId'
	UPDATE Organization
	SET Organization.TimeZoneId = 8,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.TimeZoneId IS NULL
	AND Organization.OrganizationTimeZone IN ('HT', 'HS')

	UPDATE Organization
	SET Organization.TimeZoneId = 7,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	-- select * from Organization
	WHERE Organization.TimeZoneId IS NULL
	AND Organization.OrganizationTimeZone IN ('AT', 'AS')

	UPDATE Organization
	SET Organization.TimeZoneId = 6,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.TimeZoneId IS NULL
	AND Organization.OrganizationTimeZone IN ('PT', 'PS')

	UPDATE Organization
	SET Organization.TimeZoneId = 5,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.TimeZoneId IS NULL
	AND Organization.OrganizationTimeZone IN ('MT', 'MS')
	AND Organization.StateID = 3

	UPDATE Organization
	SET Organization.TimeZoneId = 4,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.TimeZoneId IS NULL
	AND Organization.OrganizationTimeZone IN ('MT', 'MS')

	UPDATE Organization
	SET Organization.TimeZoneId = 3,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.TimeZoneId IS NULL
	AND Organization.OrganizationTimeZone IN ('CT', 'CS')

	UPDATE Organization
	SET Organization.TimeZoneId = 2,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.TimeZoneId IS NULL
	AND Organization.OrganizationTimeZone IN ('ET', 'ES')

	UPDATE Organization
	SET Organization.TimeZoneId = 5,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.TimeZoneId IS NULL	
	AND Organization.StateID = 3

	PRINT 'SET PhoneID to Null where not a valid ID'
	UPDATE Organization
	SET Organization.PhoneId = null,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.PhoneId < 1

	PRINT 'SET ObservesDaylightSavings'
	UPDATE Organization
	SET Organization.ObservesDaylightSavings = 1,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3	
	WHERE Organization.ObservesDaylightSavings is null
	AND OrganizationTimeZone like '%T'
	
	UPDATE Organization
	SET Organization.ObservesDaylightSavings = 0,
	Organization.LastModified = GETDATE(),
	Organization.LastStatEmployeeID = 45,
	Organization.AuditLogTypeID = 3
	WHERE Organization.ObservesDaylightSavings is null
	
	UPDATE Organization
	SET 
		IddId = CASE WHEN IddId IS NULL THEN 57 ELSE IddId END,
		CountryCodeId = CASE WHEN CountryCodeId IS NULL THEN 1 ELSE CountryCodeId END,
		ContractedStatlineClient = CASE WHEN ContractedStatlineClient IS NULL THEN 0 ELSE ContractedStatlineClient END,
		Organization.Inactive = CASE WHEN Inactive IS NULL THEN 0 ELSE Inactive END

	UPDATE Organization
	SET ProviderNumber = OrganizationUserCode
	WHERE ProviderNumber IS NULL
	
	UPDATE Organization 
	SET StatTracOrganization = 1
	WHERE OrganizationID IN (14019,2309, 2257, 1100, 5115, 194 )
		