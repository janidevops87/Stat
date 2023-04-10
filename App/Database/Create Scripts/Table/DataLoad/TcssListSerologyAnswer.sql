/***************************************************************************************************
**	Name: TcssListSerologyAnswer
**	Desc: Data Load for table TcssListSerologyAnswer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListSerologyAnswer ON

IF ((SELECT count(*) FROM TcssListSerologyAnswer) = 0)
BEGIN
	INSERT INTO TcssListSerologyAnswer (TcssListSerologyAnswerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListSerologyAnswer (TcssListSerologyAnswerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
	INSERT INTO TcssListSerologyAnswer (TcssListSerologyAnswerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
	INSERT INTO TcssListSerologyAnswer (TcssListSerologyAnswerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Not Done', 'Not Done')
	INSERT INTO TcssListSerologyAnswer (TcssListSerologyAnswerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Indeterminate', 'Indeterminate')
	INSERT INTO TcssListSerologyAnswer (TcssListSerologyAnswerId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Pending', 'Pending')
END

UPDATE TcssListSerologyAnswer SET UnosValue = 'Pending...' WHERE TcssListSerologyAnswerId = 6

SET IDENTITY_INSERT TcssListSerologyAnswer OFF
GO
