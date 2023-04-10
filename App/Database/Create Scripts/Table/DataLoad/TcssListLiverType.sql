/***************************************************************************************************
**	Name: TcssListLiverType
**	Desc: Data Load for table TcssListLiverType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListLiverType ON

IF ((SELECT count(*) FROM TcssListLiverType) = 0)
BEGIN
	INSERT INTO TcssListLiverType (TcssListLiverTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Right Lobe', 'Right Lobe')
	INSERT INTO TcssListLiverType (TcssListLiverTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Left Lobe', 'Left Lobe')
	INSERT INTO TcssListLiverType (TcssListLiverTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Whole', 'Whole')
END

SET IDENTITY_INSERT TcssListLiverType OFF
GO
