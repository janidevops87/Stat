/***************************************************************************************************
**	Name: TcssListKidneyArtery
**	Desc: Data Load for table TcssListKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyArtery ON

IF ((SELECT count(*) FROM TcssListKidneyArtery) = 0)
BEGIN
	INSERT INTO TcssListKidneyArtery (TcssListKidneyArteryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', '1.', '1.')
	INSERT INTO TcssListKidneyArtery (TcssListKidneyArteryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', '2.', '2.')
	INSERT INTO TcssListKidneyArtery (TcssListKidneyArteryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', '3.', '3.')
	INSERT INTO TcssListKidneyArtery (TcssListKidneyArteryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', '4.', '4.')
END

SET IDENTITY_INSERT TcssListKidneyArtery OFF
GO
