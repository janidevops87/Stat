/***************************************************************************************************
**	Name: TcssListDiagnosisHeartMethod
**	Desc: Data Load for table TcssListDiagnosisHeartMethod
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDiagnosisHeartMethod ON

IF ((SELECT count(*) FROM TcssListDiagnosisHeartMethod) = 0)
BEGIN
	INSERT INTO TcssListDiagnosisHeartMethod (TcssListDiagnosisHeartMethodId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Echo', 'Echo')
	INSERT INTO TcssListDiagnosisHeartMethod (TcssListDiagnosisHeartMethodId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'MUGA', 'MUGA')
	INSERT INTO TcssListDiagnosisHeartMethod (TcssListDiagnosisHeartMethodId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Angiogram', 'Angiogram')
END

SET IDENTITY_INSERT TcssListDiagnosisHeartMethod OFF
GO
