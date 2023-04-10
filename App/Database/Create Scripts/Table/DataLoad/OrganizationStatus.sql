/***************************************************************************************************
**	Name: OrganizationStatus
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM OrganizationStatus) = 0)
BEGIN
	SET IDENTITY_INSERT OrganizationStatus ON
	INSERT OrganizationStatus (OrganizationStatusID, OrganizationStatusName, LastModified, LastStatEmployeeId, AuditLogTypeId)
	VALUES(1, 'Active / Not Verified', GETDATE(), 45, 1),
	(2, 'Active / Verified', GETDATE(), 45, 1),
	(3, 'Inactive', GETDATE(), 45, 1)

	SET IDENTITY_INSERT OrganizationStatus OFF
END

