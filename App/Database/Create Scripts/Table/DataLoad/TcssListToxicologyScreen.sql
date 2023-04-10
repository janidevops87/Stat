/***************************************************************************************************
**	Name: TcssListToxicologyScreen
**	Desc: Data Load for table TcssListToxicologyScreen
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/30/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListToxicologyScreen ON

IF ((SELECT count(*) FROM TcssListToxicologyScreen) = 0)
BEGIN
	INSERT INTO TcssListToxicologyScreen (TcssListToxicologyScreenId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Y', 'Y')
	INSERT INTO TcssListToxicologyScreen (TcssListToxicologyScreenId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'N', 'N')
END

SET IDENTITY_INSERT TcssListToxicologyScreen OFF
GO
