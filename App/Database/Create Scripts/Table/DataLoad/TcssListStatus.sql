/***************************************************************************************************
**	Name: TcssListStatus
**	Desc: Data Load for table TcssListStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListStatus ON

IF ((SELECT count(*) FROM TcssListStatus) = 0)
BEGIN
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Receipt Pending', 'Receipt Pending')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Acknowledge to Evaluate', 'Acknowledge to Evaluate')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Labs/Tests Pending', 'Labs/Tests Pending')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Labs Received', 'Labs Received')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Contact Transplant Coordinator', 'Contact Transplant Coordinator')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Contact Surgeon', 'Contact Surgeon')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'List Monitoring', 'List Monitoring')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'QA', 'QA')
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'Closed', 'Closed')
END


IF ((SELECT count(*) FROM TcssListStatus where TcssListStatusId = 10) = 0)
BEGIN
	INSERT INTO TcssListStatus (TcssListStatusId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '1499', '10', 'Re-Open', 'Re-Open')
END
SET IDENTITY_INSERT TcssListStatus OFF
GO
