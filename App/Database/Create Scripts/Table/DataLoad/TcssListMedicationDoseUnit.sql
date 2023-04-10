/***************************************************************************************************
**	Name: TcssListMedicationDoseUnit
**	Desc: Data Load for table TcssListMedicationDoseUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListMedicationDoseUnit ON

IF ((SELECT count(*) FROM TcssListMedicationDoseUnit) = 0)
BEGIN
	INSERT INTO TcssListMedicationDoseUnit (TcssListMedicationDoseUnitId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'mcg/kg/min', 'mcg/kg/min')
	INSERT INTO TcssListMedicationDoseUnit (TcssListMedicationDoseUnitId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'mcg/min', 'mcg/min')
	INSERT INTO TcssListMedicationDoseUnit (TcssListMedicationDoseUnitId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'mg/min', 'mg/min')
	INSERT INTO TcssListMedicationDoseUnit (TcssListMedicationDoseUnitId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'units/hr', 'units/hr')
	INSERT INTO TcssListMedicationDoseUnit (TcssListMedicationDoseUnitId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'mcg/hr', 'mcg/hr')
END

SET IDENTITY_INSERT TcssListMedicationDoseUnit OFF
GO


