 /***************************************************************************************************
**	Name: AspSettingType
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM AspSettingType) = 0)
BEGIN

INSERT AspSettingType (AspSettingType, LastModified, LastStatEmployeeId, AuditLogTypeId)
VALUES('Triage ASP Only', GETDATE(), 45, 1),
('Family Services ASP Only', GETDATE(), 45, 1),
('Triage and Family Services ASP', GETDATE(), 45, 1)
	
	

END

