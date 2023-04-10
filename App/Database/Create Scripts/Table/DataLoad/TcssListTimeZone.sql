/***************************************************************************************************
**	Name: TcssListTimeZone
**	Desc: Data Load for table TcssListTimeZone
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListTimeZone ON

IF ((SELECT count(*) FROM TcssListTimeZone) = 0)
BEGIN
	INSERT INTO TcssListTimeZone (TcssListTimeZoneId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Atlantic', 'Atlantic')
	INSERT INTO TcssListTimeZone (TcssListTimeZoneId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Eastern', 'Eastern')
	INSERT INTO TcssListTimeZone (TcssListTimeZoneId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Central', 'Central')
	INSERT INTO TcssListTimeZone (TcssListTimeZoneId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Mountain', 'Mountain')
	INSERT INTO TcssListTimeZone (TcssListTimeZoneId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Pacific', 'Pacific')
	INSERT INTO TcssListTimeZone (TcssListTimeZoneId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Alaska', 'Alaska')
	INSERT INTO TcssListTimeZone (TcssListTimeZoneId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Hawaii', 'Hawaii')
END

SET IDENTITY_INSERT TcssListTimeZone OFF
GO
