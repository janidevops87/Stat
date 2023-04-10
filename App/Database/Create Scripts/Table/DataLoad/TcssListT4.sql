/***************************************************************************************************
**	Name: TcssListT4
**	Desc: Data Load for table TcssListT4
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListT4 ON

IF ((SELECT count(*) FROM TcssListT4) = 0)
BEGIN
	INSERT INTO TcssListT4 (TcssListT4Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListT4 (TcssListT4Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListT4 OFF
GO
