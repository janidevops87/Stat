/***************************************************************************************************
**	Name: TcssListCallType
**	Desc: Data Load for table TcssListCallType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCallType ON

IF ((SELECT count(*) FROM TcssListCallType) = 0)
BEGIN
	INSERT INTO TcssListCallType (TcssListCallTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'TCSS', 'TCSS')
END

SET IDENTITY_INSERT TcssListCallType OFF
GO
