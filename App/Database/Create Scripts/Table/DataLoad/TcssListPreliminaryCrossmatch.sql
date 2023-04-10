/***************************************************************************************************
**	Name: TcssListPreliminaryCrossmatch
**	Desc: Data Load for table TcssListPreliminaryCrossmatch
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListPreliminaryCrossmatch ON

IF ((SELECT count(*) FROM TcssListPreliminaryCrossmatch) = 0)
BEGIN
	INSERT INTO TcssListPreliminaryCrossmatch (TcssListPreliminaryCrossmatchId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListPreliminaryCrossmatch (TcssListPreliminaryCrossmatchId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListPreliminaryCrossmatch OFF
GO
