/***************************************************************************************************
**	Name: TcssListKidneyType
**	Desc: Data Load for table TcssListKidneyType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyType ON

IF ((SELECT count(*) FROM TcssListKidneyType) = 0)
BEGIN
	INSERT INTO TcssListKidneyType (TcssListKidneyTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Right', 'Right')
	INSERT INTO TcssListKidneyType (TcssListKidneyTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Left', 'Left')
	INSERT INTO TcssListKidneyType (TcssListKidneyTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Enbloc', 'Enbloc')
END

SET IDENTITY_INSERT TcssListKidneyType OFF
GO
