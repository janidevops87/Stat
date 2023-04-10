 /***************************************************************************************************
**	Name: OrganizationDuplicateSearchRule
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM OrganizationDuplicateSearchRule) = 0)
BEGIN
	PRINT 'Loading OrganizationDuplicateSearchRule Data'
	
	

END

