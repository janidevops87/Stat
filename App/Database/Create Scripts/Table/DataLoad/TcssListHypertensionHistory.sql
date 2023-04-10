/***************************************************************************************************
**	Name: TcssListHypertensionHistory
**	Desc: Data Load for table TcssListHypertensionHistory
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHypertensionHistory ON

IF ((SELECT count(*) FROM TcssListHypertensionHistory) = 0)
BEGIN
	INSERT INTO TcssListHypertensionHistory (TcssListHypertensionHistoryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'No', 'No')
	INSERT INTO TcssListHypertensionHistory (TcssListHypertensionHistoryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Yes, 0-5 Years', 'Yes, 0-5 Years')
	INSERT INTO TcssListHypertensionHistory (TcssListHypertensionHistoryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Yes, 6-10 Years', 'Yes, 6-10 Years')
	INSERT INTO TcssListHypertensionHistory (TcssListHypertensionHistoryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Yes, >10 Years', 'Yes, >10 Years')
	INSERT INTO TcssListHypertensionHistory (TcssListHypertensionHistoryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Yes, Duration Unknown', 'Yes, Duration Unknown')
	INSERT INTO TcssListHypertensionHistory (TcssListHypertensionHistoryId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListHypertensionHistory OFF
GO
