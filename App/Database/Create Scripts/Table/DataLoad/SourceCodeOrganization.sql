  /***************************************************************************************************
**	Name: SourceCodeOrganization
**	Desc: Data Load for table SourceCodeOrganization
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/
PRINT 'Remove records with SourceCodeID less than 1'
DELETE SourceCodeOrganization WHERE SourceCodeID < 1

PRINT 'Remove records with OrganizationID less than 1'
DELETE SourceCodeOrganization WHERE OrganizationID < 1

PRINT 'Remove records from SourceCodeOrganization where OrganizationID not in Organization Table'
DELETE FROM SourceCodeOrganization WHERE OrganizationID not in (SELECT OrganizationID FROM Organization)


PRINT 'Remove records from SourceCodeOrganization where SourceCodeID does not exist in SourceCode'
DELETE SourceCodeOrganization
FROM SourceCodeOrganization
LEFT OUTER JOIN SourceCode ON SourceCodeOrganization.SourceCodeID = SourceCode.SourceCodeID
WHERE SourceCode.SourceCodeID IS NULL