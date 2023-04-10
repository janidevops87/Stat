/***************************************************************************************************
**	Name: TcssListKidneySubcapsular
**	Desc: Data Load for table TcssListKidneySubcapsular
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneySubcapsular ON

IF ((SELECT count(*) FROM TcssListKidneySubcapsular) = 0)
BEGIN
	INSERT INTO TcssListKidneySubcapsular (TcssListKidneySubcapsularId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneySubcapsular (TcssListKidneySubcapsularId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneySubcapsular OFF
GO
