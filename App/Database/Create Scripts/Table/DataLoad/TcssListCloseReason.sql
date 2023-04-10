/***************************************************************************************************
**	Name: TcssListCloseReason
**	Desc: Data Load for table TcssListCloseReason
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCloseReason ON

IF ((SELECT count(*) FROM TcssListCloseReason) = 0)
BEGIN
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Closed - Placed Higher Sequence', 'Closed - Placed Higher Sequence')
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Closed - New Match Run', 'Closed - New Match Run')
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Closed - Matched', 'Closed - Matched')
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Closed - Refused for All Patients', 'Closed - Refused for All Patients')
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Closed - Donor Aborted', 'Closed - Donor Aborted')
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Closed - Did Not Die', 'Closed - Did Not Die')
END

IF ((SELECT count(*) FROM TcssListCloseReason) = 6)
BEGIN
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Closed - Passed to Tx Center', 'Closed - Passed to Tx Center')
END


IF ((SELECT count(*) FROM TcssListCloseReason) = 7)
BEGIN
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'Closed - Cross-clamp Time', 'Closed - Cross-clamp Time')
	INSERT INTO TcssListCloseReason (TcssListCloseReasonId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'Closed - Exceeded Time', 'Closed - Exceeded Time')
END

SET IDENTITY_INSERT TcssListCloseReason OFF
GO
