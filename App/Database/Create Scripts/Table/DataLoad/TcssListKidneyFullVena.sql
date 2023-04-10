/***************************************************************************************************
**	Name: TcssListKidneyFullVena
**	Desc: Data Load for table TcssListKidneyFullVena
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyFullVena ON

IF ((SELECT count(*) FROM TcssListKidneyFullVena) = 0)
BEGIN
	INSERT INTO TcssListKidneyFullVena (TcssListKidneyFullVenaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyFullVena (TcssListKidneyFullVenaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyFullVena OFF
GO
