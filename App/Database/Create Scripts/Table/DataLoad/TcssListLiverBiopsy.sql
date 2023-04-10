/***************************************************************************************************
**	Name: TcssListLiverBiopsy
**	Desc: Data Load for table TcssListLiverBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListLiverBiopsy ON

IF ((SELECT count(*) FROM TcssListLiverBiopsy) = 0)
BEGIN
	INSERT INTO TcssListLiverBiopsy (TcssListLiverBiopsyId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListLiverBiopsy (TcssListLiverBiopsyId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListLiverBiopsy OFF
GO
