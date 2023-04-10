/***************************************************************************************************
**	Name: TcssListHlaDr53
**	Desc: Data Load for table TcssListHlaDr53
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHlaDr53 ON

IF ((SELECT count(*) FROM TcssListHlaDr53) = 0)
BEGIN
	INSERT INTO TcssListHlaDr53 (TcssListHlaDr53Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListHlaDr53 (TcssListHlaDr53Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
	INSERT INTO TcssListHlaDr53 (TcssListHlaDr53Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Not Tested', 'Not Tested')
END

SET IDENTITY_INSERT TcssListHlaDr53 OFF
GO
