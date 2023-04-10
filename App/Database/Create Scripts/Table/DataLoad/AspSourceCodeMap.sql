 /***************************************************************************************************
**	Name: AspSourceCodeMap
**	Desc: Add Initial Data to the AspSourceCodeName column
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/09/2009	ccarroll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM AspSourceCodeMap WHERE AspSourceCodeName is Null) > 0)
BEGIN
UPDATE AspSourceCodeMap
	SET AspSourceCodeName = SourceCodeName 
	FROM AspSourceCodeMap 
	JOIN SourceCode ON SourceCode.SourceCodeID = AspSourceCodeMap.AspSourceCodeID
WHERE AspSourceCodeName is Null
END

