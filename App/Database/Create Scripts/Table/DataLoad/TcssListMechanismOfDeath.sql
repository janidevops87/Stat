/***************************************************************************************************
**	Name: TcssListMechanismOfDeath
**	Desc: Data Load for table TcssListMechanismOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListMechanismOfDeath ON

IF ((SELECT count(*) FROM TcssListMechanismOfDeath) = 0)
BEGIN
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Drowning', 'Drowning')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Seizure', 'Seizure')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Drug Intoxication', 'rug Intoxication')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Asphyxiation', 'Asphyxiation')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Cardovascular', 'Cardovascular')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Electrical', 'Electrical')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Gunshot Wound', 'Gunshot Wound')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'Stab', 'Stab')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'Blunt Injury', 'Blunt Injury')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', 'SIDS', 'SIDS')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', 'Intracranial Hemorrahage/Stroke', 'Intracranial Hemorrahage/Stroke')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', 'Death from Natural Causes', 'Death from Natural Causes')
	INSERT INTO TcssListMechanismOfDeath (TcssListMechanismOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('13', '679', '13', 'None of the Above', 'None of the Above')
END

UPDATE TcssListMechanismOfDeath SET FieldValue = 'Drug Intoxication', UnosValue = 'Drug Intoxication' WHERE TcssListMechanismOfDeathId = 3
UPDATE TcssListMechanismOfDeath SET FieldValue = 'Intracranial Hemorrhage/Stroke', UnosValue = 'Intracranial Hemorrhage/Stroke' WHERE TcssListMechanismOfDeathId =11
UPDATE TcssListMechanismOfDeath SET FieldValue = 'Cardiovascular', UnosValue = 'Cardiovascular' WHERE TcssListMechanismOfDeathId = 5

SET IDENTITY_INSERT TcssListMechanismOfDeath OFF
GO
