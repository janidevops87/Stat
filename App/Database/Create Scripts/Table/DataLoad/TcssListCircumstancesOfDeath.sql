/***************************************************************************************************
**	Name: TcssListCircumstancesOfDeath
**	Desc: Data Load for table TcssListCircumstancesOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCircumstancesOfDeath ON

IF ((SELECT count(*) FROM TcssListCircumstancesOfDeath) = 0)
BEGIN
	INSERT INTO TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'MVA', 'MVA')
	INSERT INTO TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Suicide', 'Suicide')
	INSERT INTO TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Homicide', 'Homicide')
	INSERT INTO TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Child-Abuse', 'Child-Abuse')
	INSERT INTO TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Non-MVA', 'Non-MVA')
	INSERT INTO TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Death from Natural Causes', 'Death from Natural Causes')
	INSERT INTO TcssListCircumstancesOfDeath (TcssListCircumstancesOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'None of the Above', 'None of the Above')
END

SET IDENTITY_INSERT TcssListCircumstancesOfDeath OFF
GO
