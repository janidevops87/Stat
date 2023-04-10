 /***************************************************************************************************
**	Name: CallType
**	Desc: Data Load for table CallType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/05/2009	ccarroll		add values for for StatTrac 9.0 release
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

SET IDENTITY_INSERT CallType ON;

IF ((SELECT count(*) FROM CallType WHERE CallTypeID = 4) = 0)
BEGIN
	INSERT INTO CallType (CallTypeId, CallTypeName, Inactive, Verified) 
	VALUES
	(4, 'Import', 0, 0)
END

IF ((SELECT count(*) FROM CallType WHERE CallTypeID = 5 AND CallTypeName = 'Information') = 1)
BEGIN
	UPDATE CallType 
		SET CallTypeName = 'COD'
	WHERE CallTypeID = 5 AND CallTypeName = 'Information'
END


IF ((SELECT count(*) FROM CallType WHERE CallTypeID = 6) = 0)
BEGIN
	INSERT INTO CallType (CallTypeId, CallTypeName, Inactive, Verified) 
	VALUES
	(6, 'OASIS', 0, 0)
END



SET IDENTITY_INSERT CallType OFF;
GO
 
