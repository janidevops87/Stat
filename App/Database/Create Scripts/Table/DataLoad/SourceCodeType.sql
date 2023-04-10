 /***************************************************************************************************
**	Name: SourceCodeType
**	Desc: Data Load for table SourceCodeType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Data Load
**	07/09/2010	ccarroll		Added this note for development build (GenerateSQL)
**	04/21/2011  ccarroll		Added OASIS source code
***************************************************************************************************/

SET IDENTITY_INSERT SourceCodeType ON

IF ((SELECT count(*) FROM SourceCodeType) = 0)
BEGIN
	INSERT INTO SourceCodeType (SourceCodeTypeId, SourceCodeTypeName, LastStatEmployeeId, LastModified, AuditLogTypeID) 
	VALUES
	(1, 'Referral', 45, getdate(), 1),
	(2, 'Message', 45, getdate(), 1),	
	(4, 'Import', 45, getdate(), 1),
	(5, 'COD', 45, getdate(), 1)
END

/*Add additional SourceCode Types here */

IF ((SELECT count(*) FROM SourceCodeType WHERE SourceCodeTypeID = 6) = 0)
BEGIN
	INSERT INTO SourceCodeType (SourceCodeTypeId, SourceCodeTypeName, LastStatEmployeeId, LastModified, AuditLogTypeID) 
	VALUES
	(6, 'OASIS', 1100, getdate(), 1)
END


SET IDENTITY_INSERT SourceCodeType OFF
GO
