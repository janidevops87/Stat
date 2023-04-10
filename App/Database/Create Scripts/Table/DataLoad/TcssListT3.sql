/***************************************************************************************************
**	Name: TcssListT3
**	Desc: Data Load for table TcssListT3
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListT3 ON

IF ((SELECT count(*) FROM TcssListT3) = 0)
BEGIN
	INSERT INTO TcssListT3 (TcssListT3Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListT3 (TcssListT3Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListT3 OFF
GO
