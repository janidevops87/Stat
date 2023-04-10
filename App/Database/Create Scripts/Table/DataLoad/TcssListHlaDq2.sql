/***************************************************************************************************
**	Name: TcssListHlaDq2
**	Desc: Data Load for table TcssListHlaDq2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHlaDq2 ON

IF ((SELECT count(*) FROM TcssListHlaDq2) = 0)
BEGIN
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', '0', '0')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', '1', '1')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', '2', '2')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', '3', '3')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', '4', '4')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', '5', '5')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', '6', '6')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', '7', '7')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', '8', '8')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', '9', '9')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', 'No Second Antigen Detected', 'No Second Antigen Detected')
	INSERT INTO TcssListHlaDq2 (TcssListHlaDq2Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', 'Not Tested', 'Not Tested')
END

SET IDENTITY_INSERT TcssListHlaDq2 OFF
GO
