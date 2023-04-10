/***************************************************************************************************
**	Name: TcssListHistoryOfGastrointestinalDisease
**	Desc: Data Load for table TcssListHistoryOfGastrointestinalDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHistoryOfGastrointestinalDisease ON

IF ((SELECT count(*) FROM TcssListHistoryOfGastrointestinalDisease) = 0)
BEGIN
	INSERT INTO TcssListHistoryOfGastrointestinalDisease (TcssListHistoryOfGastrointestinalDiseaseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListHistoryOfGastrointestinalDisease (TcssListHistoryOfGastrointestinalDiseaseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListHistoryOfGastrointestinalDisease (TcssListHistoryOfGastrointestinalDiseaseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListHistoryOfGastrointestinalDisease OFF
GO
