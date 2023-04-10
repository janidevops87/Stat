/**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)**/

DECLARE @requestorCount INT = (SELECT COUNT(*) FROM PagerType) 
IF(@requestorCount = 0)
BEGIN
	PRINT 'ADDING PagerType'
	INSERT PagerType (PagerType, AuditLogTypeID, LastModified, LastStatEmployeeID)
	VALUES
	('Email',1, GETDATE(), 45)
	,('Digital',1, GETDATE(), 45)
	,('Text',1, GETDATE(), 45)

END 
