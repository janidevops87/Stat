/***************************************************************************************************
**	Name: TcssListHistoryOfCoronaryArteryDisease
**	Desc: Data Load for table TcssListHistoryOfCoronaryArteryDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHistoryOfCoronaryArteryDisease ON

IF ((SELECT count(*) FROM TcssListHistoryOfCoronaryArteryDisease) = 0)
BEGIN
	INSERT INTO TcssListHistoryOfCoronaryArteryDisease (TcssListHistoryOfCoronaryArteryDiseaseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListHistoryOfCoronaryArteryDisease (TcssListHistoryOfCoronaryArteryDiseaseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListHistoryOfCoronaryArteryDisease (TcssListHistoryOfCoronaryArteryDiseaseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListHistoryOfCoronaryArteryDisease OFF
GO
