/***************************************************************************************************
**	Name: TcssListKidneyBiopsy
**	Desc: Data Load for table TcssListKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyBiopsy ON

IF ((SELECT count(*) FROM TcssListKidneyBiopsy) = 0)
BEGIN
	INSERT INTO TcssListKidneyBiopsy (TcssListKidneyBiopsyId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyBiopsy (TcssListKidneyBiopsyId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyBiopsy OFF
GO
