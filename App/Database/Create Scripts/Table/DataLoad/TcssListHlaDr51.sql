/***************************************************************************************************
**	Name: TcssListHlaDr51
**	Desc: Data Load for table TcssListHlaDr51
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHlaDr51 ON

IF ((SELECT count(*) FROM TcssListHlaDr51) = 0)
BEGIN
	INSERT INTO TcssListHlaDr51 (TcssListHlaDr51Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListHlaDr51 (TcssListHlaDr51Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
	INSERT INTO TcssListHlaDr51 (TcssListHlaDr51Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Not Tested', 'Not Tested')
END

SET IDENTITY_INSERT TcssListHlaDr51 OFF
GO
