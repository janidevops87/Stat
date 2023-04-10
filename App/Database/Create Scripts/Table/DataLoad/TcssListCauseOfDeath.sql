/***************************************************************************************************
**	Name: TcssListCauseOfDeath
**	Desc: Data Load for table TcssListCauseOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCauseOfDeath ON

IF ((SELECT count(*) FROM TcssListCauseOfDeath) = 0)
BEGIN
	INSERT INTO TcssListCauseOfDeath (TcssListCauseOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Anoxia', 'Anoxia')
	INSERT INTO TcssListCauseOfDeath (TcssListCauseOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Cerebrovasular/Stroke', 'Cerebrovasular/Stroke')
	INSERT INTO TcssListCauseOfDeath (TcssListCauseOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'CNS Tumor', 'CNS Tumor')
	INSERT INTO TcssListCauseOfDeath (TcssListCauseOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Head Trauma', 'Head Trauma')
	INSERT INTO TcssListCauseOfDeath (TcssListCauseOfDeathId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Other (specify)', 'Other (specify)')
END

UPDATE TcssListCauseOfDeath SET FieldValue = 'Cerebrovascular/Stroke', UnosValue = 'Cerebrovascular/Stroke' WHERE TcssListCauseOfDeathId = 2

SET IDENTITY_INSERT TcssListCauseOfDeath OFF
GO
