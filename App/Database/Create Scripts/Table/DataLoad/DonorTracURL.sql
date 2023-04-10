  /***************************************************************************************************
**	Name: DonorTracURL
**	Desc: Add SourceCodeID to new column
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/11/2009	ccarroll		Initial Script Creation
**  Known Issue - OHLB is in Production table and not valid SourceCode and will not receicve update
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM DonorTracURL WHERE SourceCodeID is Null) > 0)
BEGIN
UPDATE DonorTracURL
	SET DonorTracURL.SourceCodeID = SourceCode.SourceCodeID,
		DonorTracURL.LastModified = GETDATE(),
		DonorTracURL.LastStatEmployeeID = 1100,
		DonorTracURL.AuditLogTypeID = 1 -- Insert(Initial) 
	FROM DonorTracURL
	JOIN SourceCode ON SourceCode.SourceCodeName = DonorTracURL.SourceCode
WHERE DonorTracURL.SourceCodeID is Null AND SourceCode.SourceCodeType = 1
END

