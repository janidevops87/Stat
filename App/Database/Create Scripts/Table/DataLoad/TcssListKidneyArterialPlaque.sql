/***************************************************************************************************
**	Name: TcssListKidneyArterialPlaque
**	Desc: Data Load for table TcssListKidneyArterialPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyArterialPlaque ON

IF ((SELECT count(*) FROM TcssListKidneyArterialPlaque) = 0)
BEGIN
	INSERT INTO TcssListKidneyArterialPlaque (TcssListKidneyArterialPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyArterialPlaque (TcssListKidneyArterialPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListKidneyArterialPlaque (TcssListKidneyArterialPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Hard', 'Hard')
	INSERT INTO TcssListKidneyArterialPlaque (TcssListKidneyArterialPlaqueId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Soft', 'Soft')
END

SET IDENTITY_INSERT TcssListKidneyArterialPlaque OFF
GO
