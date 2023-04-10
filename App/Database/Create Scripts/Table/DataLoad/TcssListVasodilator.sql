/***************************************************************************************************
**	Name: TcssListVasodilator
**	Desc: Data Load for table TcssListVasodilator
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListVasodilator ON

IF ((SELECT count(*) FROM TcssListVasodilator) = 0)
BEGIN
	INSERT INTO TcssListVasodilator (TcssListVasodilatorId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListVasodilator (TcssListVasodilatorId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListVasodilator OFF
GO
