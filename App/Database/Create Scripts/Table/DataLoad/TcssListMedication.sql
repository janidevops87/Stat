/***************************************************************************************************
**	Name: TcssListMedication
**	Desc: Data Load for table TcssListMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListMedication ON

IF ((SELECT count(*) FROM TcssListMedication) = 0)
BEGIN
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Dopamine', 'Dopamine')
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Dobutamine', 'Dobutamine')
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Epinephrine', 'Epinephrine')
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Levophed', 'Levophed')
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Neosynephrine', 'Neosynephrine')
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Isoproterenol (Isuprel)', 'Isoproterenol (Isuprel)')
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Other, specify', 'Other, specify')
END

IF ((SELECT count(*) FROM TcssListMedication) = 7)
BEGIN
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '7', 'Other: T4', 'Other: T4')
	UPDATE TcssListMedication SET SortOrder = 8 WHERE TcssListMedicationId = 7 -- Move "Other, specify" to the last item
END

IF ((SELECT count(*) FROM TcssListMedication) = 8)
BEGIN
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '7', 'Other: Insulin', 'Other: Insulin')
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '9', 'Other: Vasopressin', 'Other: Vasopressin')
	UPDATE TcssListMedication SET SortOrder = 10 WHERE TcssListMedicationId = 7 -- Move "Other, specify" to the last item
	UPDATE TcssListMedication SET SortOrder = 8 WHERE TcssListMedicationId = 8 -- Move "Other, specify" to the last item
END

IF ((SELECT count(*) FROM TcssListMedication) = 10)
BEGIN
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '1499', '11', 'Other: Levophed', 'Other: Levophed')
END

IF ((SELECT count(*) FROM TcssListMedication) = 11)
BEGIN
	INSERT INTO TcssListMedication (TcssListMedicationId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '1499', '12', 'Other: Pitressin', 'Other: Pitressin')
END
SET IDENTITY_INSERT TcssListMedication OFF
GO
