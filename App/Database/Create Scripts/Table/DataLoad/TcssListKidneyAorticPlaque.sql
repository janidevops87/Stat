/***************************************************************************************************
**	Name: TcssListKidneyAorticPlaque
**	Desc: Data Load for table TcssListKidneyAorticPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyAorticPlaque ON

IF ((SELECT count(*) FROM TcssListKidneyAorticPlaque) = 0)
BEGIN
	INSERT INTO TcssListKidneyAorticPlaque (TcssListKidneyAorticPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyAorticPlaque (TcssListKidneyAorticPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListKidneyAorticPlaque (TcssListKidneyAorticPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Hard', 'Hard')
	INSERT INTO TcssListKidneyAorticPlaque (TcssListKidneyAorticPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Soft', 'Soft')
END

SET IDENTITY_INSERT TcssListKidneyAorticPlaque OFF
GO
