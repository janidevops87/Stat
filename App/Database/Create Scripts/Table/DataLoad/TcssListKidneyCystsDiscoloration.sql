/***************************************************************************************************
**	Name: TcssListKidneyCystsDiscoloration
**	Desc: Data Load for table TcssListKidneyCystsDiscoloration
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyCystsDiscoloration ON

IF ((SELECT count(*) FROM TcssListKidneyCystsDiscoloration) = 0)
BEGIN
	INSERT INTO TcssListKidneyCystsDiscoloration (TcssListKidneyCystsDiscolorationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyCystsDiscoloration (TcssListKidneyCystsDiscolorationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyCystsDiscoloration OFF
GO
