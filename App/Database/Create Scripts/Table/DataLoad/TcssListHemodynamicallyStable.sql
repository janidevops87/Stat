/***************************************************************************************************
**	Name: TcssListHemodynamicallyStable
**	Desc: Data Load for table TcssListHemodynamicallyStable
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHemodynamicallyStable ON

IF ((SELECT count(*) FROM TcssListHemodynamicallyStable) = 0)
BEGIN
	INSERT INTO TcssListHemodynamicallyStable (TcssListHemodynamicallyStableId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListHemodynamicallyStable (TcssListHemodynamicallyStableId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListHemodynamicallyStable (TcssListHemodynamicallyStableId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListHemodynamicallyStable OFF
GO
