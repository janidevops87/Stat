/***************************************************************************************************
**	Name: TcssListInsulin
**	Desc: Data Load for table TcssListInsulin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListInsulin ON

IF ((SELECT count(*) FROM TcssListInsulin) = 0)
BEGIN
	INSERT INTO TcssListInsulin (TcssListInsulinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListInsulin (TcssListInsulinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListInsulin OFF
GO
