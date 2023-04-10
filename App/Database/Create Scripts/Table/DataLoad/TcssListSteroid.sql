/***************************************************************************************************
**	Name: TcssListSteroid
**	Desc: Data Load for table TcssListSteroid
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListSteroid ON

IF ((SELECT count(*) FROM TcssListSteroid) = 0)
BEGIN
	INSERT INTO TcssListSteroid (TcssListSteroidId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Y')
	INSERT INTO TcssListSteroid (TcssListSteroidId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'N')
END

SET IDENTITY_INSERT TcssListSteroid OFF
GO
