/***************************************************************************************************
**	Name: TcssListDiuretic
**	Desc: Data Load for table TcssListDiuretic
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDiuretic ON

IF ((SELECT count(*) FROM TcssListDiuretic) = 0)
BEGIN
	INSERT INTO TcssListDiuretic (TcssListDiureticId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDiuretic (TcssListDiureticId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListDiuretic OFF
GO
