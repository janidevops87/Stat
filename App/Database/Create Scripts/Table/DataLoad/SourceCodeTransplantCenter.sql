  /***************************************************************************************************
**	Name: SourceCodeTransplantCenter
**	Desc: Update SourceCodeTransplantCenter table
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/12/2009	ccarroll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM SourceCodeTransplantCenter WHERE SourceCodeTransplantCenter.OrganizationName is Null) > 0)
BEGIN
UPDATE SourceCodeTransplantCenter
	SET
		SourceCodeTransplantCenter.OrganizationName = Organization.OrganizationName,
		SourceCodeTransplantCenter.LastModified = GETDATE(),
		SourceCodeTransplantCenter.LastStatEmployeeID = 1100,
		SourceCodeTransplantCenter.AuditLogTypeID = 1 -- Insert(Initial) 

	FROM SourceCodeTransplantCenter 
	JOIN Organization ON Organization.OrganizationID = SourceCodeTransplantCenter.OrganizationID
WHERE SourceCodeTransplantCenter.OrganizationName  is Null
END

