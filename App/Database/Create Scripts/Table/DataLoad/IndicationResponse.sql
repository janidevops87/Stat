 /***************************************************************************************************
**	Name: IndicationResponse
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/202009	ccarroll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF ((SELECT COUNT(*) FROM IndicationResponse) = 0)
BEGIN
	SET IDENTITY_INSERT IndicationResponse ON
	INSERT IndicationResponse (IndicationResponseID, IndicationResponseName, LastModified, LastStatEmployeeId, AuditLogTypeId)
	VALUES(1, 'Medical Rule Out', GETDATE(), 1100, 1),
		  (2, 'High Risk', GETDATE(), 1100, 1),
	      (3, 'Additional Questions', GETDATE(), 1100, 1)

	SET IDENTITY_INSERT IndicationResponse OFF
END

