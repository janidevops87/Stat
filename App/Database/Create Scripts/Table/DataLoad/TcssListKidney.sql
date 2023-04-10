/***************************************************************************************************
**	Name: TcssListKidney
**	Desc: Data Load for table TcssListKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidney ON

IF ((SELECT count(*) FROM TcssListKidney) = 0)
BEGIN
	INSERT INTO TcssListKidney (TcssListKidneyId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Left', 'Left')
	INSERT INTO TcssListKidney (TcssListKidneyId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Right', 'Right')
END

SET IDENTITY_INSERT TcssListKidney OFF
GO
