/***************************************************************************************************
**	Name: TcssListHlaC1
**	Desc: Data Load for table TcssListHlaC1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHlaC1 ON

IF ((SELECT count(*) FROM TcssListHlaC1) = 0)
BEGIN
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', '1', '1')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', '2', '2')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', '3', '3')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', '4', '4')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', '5', '5')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', '6', '6')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', '7', '7')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', '8', '8')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', '9', '9')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', '10', '10')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', '12', '12')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', '13', '13')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('13', '679', '13', '14', '14')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('14', '679', '14', '15', '15')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('15', '679', '15', '16', '16')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('16', '679', '16', '17', '17')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('17', '679', '17', '18', '18')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('18', '679', '18', 'No Second Antigen Detected', 'No Second Antigen Detected')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('19', '679', '19', 'No Antigen Detected', 'No Antigen Detected')
	INSERT INTO TcssListHlaC1 (TcssListHlaC1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('20', '679', '20', 'Not Tested', 'Not Tested')
END

SET IDENTITY_INSERT TcssListHlaC1 OFF
GO
