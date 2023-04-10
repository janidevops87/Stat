/***************************************************************************************************
**	Name: TcssListDiagnosisLungChestXray
**	Desc: Data Load for table TcssListDiagnosisLungChestXray
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDiagnosisLungChestXray ON

IF ((SELECT count(*) FROM TcssListDiagnosisLungChestXray) = 0)
BEGIN
	INSERT INTO TcssListDiagnosisLungChestXray (TcssListDiagnosisLungChestXrayId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'No chest x-ray', 'ray')
	INSERT INTO TcssListDiagnosisLungChestXray (TcssListDiagnosisLungChestXrayId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Normal', 'Normal')
	INSERT INTO TcssListDiagnosisLungChestXray (TcssListDiagnosisLungChestXrayId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Abnormal-left', 'Abnormal-left')
	INSERT INTO TcssListDiagnosisLungChestXray (TcssListDiagnosisLungChestXrayId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Abnormal-right', 'Abnormal-right')
	INSERT INTO TcssListDiagnosisLungChestXray (TcssListDiagnosisLungChestXrayId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Abnormal-both', 'Abnormal-both')
	INSERT INTO TcssListDiagnosisLungChestXray (TcssListDiagnosisLungChestXrayId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Results Unknown', 'Results Unknown')
	INSERT INTO TcssListDiagnosisLungChestXray (TcssListDiagnosisLungChestXrayId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Unknown if chest x-ray performed', 'Unknown if chest x-ray performed')
END

SET IDENTITY_INSERT TcssListDiagnosisLungChestXray OFF
GO
