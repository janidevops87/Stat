/***************************************************************************************************
**	Name: TcssListGender
**	Desc: Data Load for table TcssListGender
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListGender ON

IF ((SELECT count(*) FROM TcssListGender) = 0)
BEGIN
	INSERT INTO TcssListGender (TcssListGenderId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Male', 'MALE')
	INSERT INTO TcssListGender (TcssListGenderId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Female', 'FEMALE')
END

SET IDENTITY_INSERT TcssListGender OFF
GO
