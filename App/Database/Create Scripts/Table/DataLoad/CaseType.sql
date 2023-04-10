/***************************************************************************************************
**	Name: CaseType
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM CaseType) = 0)
BEGIN
	
	PRINT 'Loading CaseType Data'
	INSERT CaseType (CaseType.CaseType, CaseType.LastModified, CaseType.LastStatEmployeeId, CaseType.AuditLogTypeId  )
	VALUES
	('Organ Referrals',GETDATE(), 45, 1), 
	('Tissue Referrals',GETDATE(), 45, 1), 
	('Eye Only Referrals', GETDATE(), 45, 1),
	('Ruled out Referrals', GETDATE(), 45, 1),
	('Messages, Import Offers', GETDATE(), 45, 1),
	('Oasis Cases', GETDATE(), 45, 1)	

END

IF EXISTS(SELECT CaseTypeID FROM CaseType WHERE CaseType = 'TCSS Cases')
BEGIN

	UPDATE CaseType
	SET CaseType = 'Oasis Cases'
	WHERE CaseType = 'TCSS Cases'

END