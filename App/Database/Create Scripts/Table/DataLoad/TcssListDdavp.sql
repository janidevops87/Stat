/***************************************************************************************************
**	Name: TcssListDdavp
**	Desc: Data Load for table TcssListDdavp
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDdavp ON

IF ((SELECT count(*) FROM TcssListDdavp) = 0)
BEGIN
	INSERT INTO TcssListDdavp (TcssListDdavpId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDdavp (TcssListDdavpId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListDdavp OFF
GO
