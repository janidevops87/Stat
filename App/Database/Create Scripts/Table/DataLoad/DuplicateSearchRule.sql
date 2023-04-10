 /***************************************************************************************************
**	Name: DuplicateSearchRule
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM DuplicateSearchRule) = 0)
BEGIN
	PRINT 'Loading DuplicateSearchRule Data'
		
	INSERT  [DuplicateSearchRule]
           ([DuplicateSearchRule]           
           ,[LastModified]
           ,[LastStatEmployeeId]
           ,[AuditLogTypeId])
     VALUES
           ('By Last Name with Cardiac Death d/t', GETDATE(),45, 1),
           ('By Last Name without Cardiac Death d/t', GETDATE(),45, 1),
           ('By Medical Record Number', GETDATE(),45, 1),
           ('Identity Unknown by Referral Facility', GETDATE(),45, 1),
           ('By Match ID, OPTN #, and Organ', GETDATE(),45, 1)
END

