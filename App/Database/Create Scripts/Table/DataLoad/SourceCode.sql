  /***************************************************************************************************
**	Name: SourceCode
**	Desc: Data Load for table SourceCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/13/2009	ccarroll		Initial
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

--Populate SourceCodeCallType column with SourceCodeType data (StatTrac Compatibility)

IF ((SELECT count(*) FROM SourceCode WHERE SourceCodeCallTypeID Is Null) > 0)
BEGIN
UPDATE SourceCode
	SET SourceCodeCallTypeID = SourceCodeType
WHERE SourceCodeCallTypeID Is Null

END

