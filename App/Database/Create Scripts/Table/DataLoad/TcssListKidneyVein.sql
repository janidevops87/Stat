/***************************************************************************************************
**	Name: TcssListKidneyVein
**	Desc: Data Load for table TcssListKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyVein ON

IF ((SELECT count(*) FROM TcssListKidneyVein) = 0)
BEGIN
	INSERT INTO TcssListKidneyVein (TcssListKidneyVeinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', '1.', '1.')
	INSERT INTO TcssListKidneyVein (TcssListKidneyVeinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', '2.', '2.')
	INSERT INTO TcssListKidneyVein (TcssListKidneyVeinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', '3.', '3.')
	INSERT INTO TcssListKidneyVein (TcssListKidneyVeinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', '4.', '4.')
END

SET IDENTITY_INSERT TcssListKidneyVein OFF
GO
