/***************************************************************************************************
**	Name: TcssListKidneyUreter
**	Desc: Data Load for table TcssListKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
**  4/5/2011    jth             double was spelled doible
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyUreter ON

IF ((SELECT count(*) FROM TcssListKidneyUreter) = 0)
BEGIN
	INSERT INTO TcssListKidneyUreter (TcssListKidneyUreterId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Single', 'Single')
	INSERT INTO TcssListKidneyUreter (TcssListKidneyUreterId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Double', 'Double')
	INSERT INTO TcssListKidneyUreter (TcssListKidneyUreterId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Triple', 'Triple')
END

UPDATE TcssListKidneyUreter SET FieldValue = 'Double' WHERE TcssListKidneyUreterId = 2
UPDATE TcssListKidneyUreter SET UnosValue = 'Double' WHERE TcssListKidneyUreterId = 2
SET IDENTITY_INSERT TcssListKidneyUreter OFF
GO
