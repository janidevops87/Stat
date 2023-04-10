/**	07/09/2010	ccarroll		added this note for development build (GenerateSQL) **/

DECLARE @requestorCount INT = (SELECT COUNT(*) FROM EmailType) 
IF(@requestorCount = 0)
BEGIN
	PRINT 'ADDING EmailType'
	INSERT EmailType (EmailType, AuditLogTypeID, LastModified, LastStatEmployeeID)
	VALUES
	('Email',1, GETDATE(), 45)
	,('Work',1, GETDATE(), 45)
	,('Home',1, GETDATE(), 45)
	,('Cell',1, GETDATE(), 45)
	,('PDA',1, GETDATE(), 45)
	,('Pager (Primary)',1, GETDATE(), 45)
	,('(Backup)',1, GETDATE(), 45)
	,('Fax (Home)',1, GETDATE(), 45)
	,('Fax (Office)',1, GETDATE(), 45)

END 
