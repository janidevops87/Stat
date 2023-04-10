/***************************************************************************************************
**	Name: TcssListHlaBw6
**	Desc: Data Load for table TcssListHlaBw6
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHlaBw6 ON

IF ((SELECT count(*) FROM TcssListHlaBw6) = 0)
BEGIN
	INSERT INTO TcssListHlaBw6 (TcssListHlaBw6Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListHlaBw6 (TcssListHlaBw6Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
	INSERT INTO TcssListHlaBw6 (TcssListHlaBw6Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Not Tested', 'Not Tested')
END

SET IDENTITY_INSERT TcssListHlaBw6 OFF
GO
