/**	07/09/2010	ccarroll		added this note for development build (GenerateSQL) */
DECLARE @requestorCount INT = (SELECT COUNT(*) FROM Gender) 
IF(@requestorCount = 0)
BEGIN
	INSERT Gender (Gender, GenderAbbreviation, AuditLogTypeID, LastModified, LastStatEmployeeID)
	VALUES
	('Male', 'M', 1, GETDATE(), 45)
	, ('Female', 'F', 1, GETDATE(), 45)
END 
