/***************************************************************************************************
**	Name: TcssListLungType
**	Desc: Data Load for table TcssListLungType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListLungType ON

IF ((SELECT count(*) FROM TcssListLungType) = 0)
BEGIN
	INSERT INTO TcssListLungType (TcssListLungTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Right', 'Right')
	INSERT INTO TcssListLungType (TcssListLungTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Left', 'Left')
	INSERT INTO TcssListLungType (TcssListLungTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Double', 'Double')
END

SET IDENTITY_INSERT TcssListLungType OFF
GO
