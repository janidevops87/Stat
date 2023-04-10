/***************************************************************************************************
**	Name: TcssListCprAdministered
**	Desc: Data Load for table TcssListCprAdministered
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCprAdministered ON

IF ((SELECT count(*) FROM TcssListCprAdministered) = 0)
BEGIN
	INSERT INTO TcssListCprAdministered (TcssListCprAdministeredId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListCprAdministered (TcssListCprAdministeredId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListCprAdministered (TcssListCprAdministeredId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListCprAdministered OFF
GO
