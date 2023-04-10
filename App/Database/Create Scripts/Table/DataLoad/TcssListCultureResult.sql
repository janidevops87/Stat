/***************************************************************************************************
**	Name: TcssListCultureResult
**	Desc: Data Load for table TcssListCultureResult
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCultureResult ON

IF ((SELECT count(*) FROM TcssListCultureResult) = 0)
BEGIN
	INSERT INTO TcssListCultureResult (TcssListCultureResultId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListCultureResult (TcssListCultureResultId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
	INSERT INTO TcssListCultureResult (TcssListCultureResultId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Pending', 'Pending')
END

SET IDENTITY_INSERT TcssListCultureResult OFF
GO
