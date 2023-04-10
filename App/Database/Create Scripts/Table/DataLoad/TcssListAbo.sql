/***************************************************************************************************
**	Name: TcssListAbo
**	Desc: Data Load for table TcssListAbo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListAbo ON

IF ((SELECT count(*) FROM TcssListAbo) = 0)
BEGIN
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'O', 'O')
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'A', '1')
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'A1', 'A1')
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'A2', 'A2')
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'B', 'B')
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'AB', 'AB')
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'A1B', 'A1B')
	INSERT INTO TcssListAbo (TcssListAboId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'A2B', 'A2B')
END

SET IDENTITY_INSERT TcssListAbo OFF
GO

UPDATE TcssListAbo SET UnosValue = 'A' WHERE TcssListAboId = 2
GO

