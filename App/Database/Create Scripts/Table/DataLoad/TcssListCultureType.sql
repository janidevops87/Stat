/***************************************************************************************************
**	Name: TcssListCultureType
**	Desc: Data Load for table TcssListCultureType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCultureType ON

IF ((SELECT count(*) FROM TcssListCultureType) = 0)
BEGIN
	INSERT INTO TcssListCultureType (TcssListCultureTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Blood', 'Blood')
	INSERT INTO TcssListCultureType (TcssListCultureTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Urine', 'Urine')
	INSERT INTO TcssListCultureType (TcssListCultureTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Sputum Gram Stain', 'Sputum Gram Stain')
	INSERT INTO TcssListCultureType (TcssListCultureTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Sputum Culture', 'Sputum Culture')
	INSERT INTO TcssListCultureType (TcssListCultureTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'CSF', 'CSF')
	INSERT INTO TcssListCultureType (TcssListCultureTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Other', 'Other')
END

SET IDENTITY_INSERT TcssListCultureType OFF
GO
