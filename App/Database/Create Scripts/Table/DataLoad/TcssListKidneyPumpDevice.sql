/***************************************************************************************************
**	Name: TcssListKidneyPumpDevice
**	Desc: Data Load for table TcssListKidneyPumpDevice
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyPumpDevice ON

IF ((SELECT count(*) FROM TcssListKidneyPumpDevice) = 0)
BEGIN
	INSERT INTO TcssListKidneyPumpDevice (TcssListKidneyPumpDeviceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'ORS', 'ORS')
	INSERT INTO TcssListKidneyPumpDevice (TcssListKidneyPumpDeviceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Waters', 'Waters')
	INSERT INTO TcssListKidneyPumpDevice (TcssListKidneyPumpDeviceId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Other specify', 'Other specify')
END

SET IDENTITY_INSERT TcssListKidneyPumpDevice OFF
GO
