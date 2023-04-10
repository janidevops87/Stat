/***************************************************************************************************
**	Name: TcssListTestType
**	Desc: Data Load for table TcssListTestType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListTestType ON

IF ((SELECT count(*) FROM TcssListTestType) = 0)
BEGIN
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Angiography', 'Angiography')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Bronchoscopy', 'Bronchoscopy')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Cardiac catheterization', 'Cardiac catheterization')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Chest x-ray', 'Chest x-ray')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'CT/MRI', 'CT/MRI')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Echocardiograms', 'Echocardiograms')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'EKGs', 'EKGs')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'Other, specify', 'Other, specify')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'Ultrasounds', 'Ultrasounds')
	
END
IF ((SELECT count(*) FROM TcssListTestType) = 9)	
Begin
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '1499', '10', 'Cerebral Blood Flow', 'Other, specify: Cerebral Blood Flow')
	INSERT INTO TcssListTestType (TcssListTestTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '1499', '11', 'CT Chest', 'Other, specify: CT Chest')
end

SET IDENTITY_INSERT TcssListTestType OFF
GO
