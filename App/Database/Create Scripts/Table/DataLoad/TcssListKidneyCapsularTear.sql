/***************************************************************************************************
**	Name: TcssListKidneyCapsularTear
**	Desc: Data Load for table TcssListKidneyCapsularTear
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyCapsularTear ON

IF ((SELECT count(*) FROM TcssListKidneyCapsularTear) = 0)
BEGIN
	INSERT INTO TcssListKidneyCapsularTear (TcssListKidneyCapsularTearId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyCapsularTear (TcssListKidneyCapsularTearId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyCapsularTear OFF
GO
