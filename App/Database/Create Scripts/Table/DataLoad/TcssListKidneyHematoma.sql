/***************************************************************************************************
**	Name: TcssListKidneyHematoma
**	Desc: Data Load for table TcssListKidneyHematoma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyHematoma ON

IF ((SELECT count(*) FROM TcssListKidneyHematoma) = 0)
BEGIN
	INSERT INTO TcssListKidneyHematoma (TcssListKidneyHematomaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyHematoma (TcssListKidneyHematomaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyHematoma OFF
GO
