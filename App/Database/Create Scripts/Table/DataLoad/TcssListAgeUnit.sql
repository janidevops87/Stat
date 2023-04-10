/***************************************************************************************************
**	Name: TcssListAgeUnit
**	Desc: Data Load for table TcssListAgeUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListAgeUnit ON

IF ((SELECT count(*) FROM TcssListAgeUnit) = 0)
BEGIN
	INSERT INTO TcssListAgeUnit (TcssListAgeUnitId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Months', 'Months')
	INSERT INTO TcssListAgeUnit (TcssListAgeUnitId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Years', 'Years')
END

SET IDENTITY_INSERT TcssListAgeUnit OFF
GO
