/***************************************************************************************************
**	Name: TcssListDaylightSavingsObserved
**	Desc: Data Load for table TcssListDaylightSavingsObserved
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDaylightSavingsObserved ON

IF ((SELECT count(*) FROM TcssListDaylightSavingsObserved) = 0)
BEGIN
	INSERT INTO TcssListDaylightSavingsObserved (TcssListDaylightSavingsObservedId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDaylightSavingsObserved (TcssListDaylightSavingsObservedId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListDaylightSavingsObserved OFF
GO
