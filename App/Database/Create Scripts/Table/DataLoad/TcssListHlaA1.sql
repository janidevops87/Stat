/***************************************************************************************************
**	Name: TcssListHlaA1
**	Desc: Data Load for table TcssListHlaA1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHlaA1 ON

IF ((SELECT count(*) FROM TcssListHlaA1) = 0)
BEGIN
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', '1', '1')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', '2', '2')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', '3', '3')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', '9', '9')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', '10', '10')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', '19', '19')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', '23', '23')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', '24', '24')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', '25', '25')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', '26', '26')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', '28', '28')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', '29', '29')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('13', '679', '13', '30', '30')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('14', '679', '14', '31', '31')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('15', '679', '15', '32', '32')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('16', '679', '16', '33', '33')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('17', '679', '17', '34', '34')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('18', '679', '18', '36', '36')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('19', '679', '19', '43', '43')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('20', '679', '20', '66', '66')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('21', '679', '21', '68', '68')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('22', '679', '22', '69', '69')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('23', '679', '23', '74', '74')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('24', '679', '24', '80', '80')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('25', '679', '25', '203', '203')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('26', '679', '26', '210', '210')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('27', '679', '27', '2403', '2403')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('28', '679', '28', '6601', '6601')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('29', '679', '29', '6602', '6602')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('30', '679', '30', 'No Second Antigen Detected', 'No Second Antigen Detected')
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('31', '679', '31', 'Not Tested', 'Not Tested')
END

SET IDENTITY_INSERT TcssListHlaA1 OFF
GO

-- Add the missed field
IF((SELECT SortOrder FROM TcssListHlaA1 WHERE TcssListHlaA1Id = 5) = 5)
BEGIN
	-- Increment the sort order off all the items that are greater
	UPDATE TcssListHlaA1
	SET SortOrder = SortOrder + 1
	WHERE TcssListHlaA1Id > 4

	-- Add the new item
	SET IDENTITY_INSERT TcssListHlaA1 ON
	INSERT INTO TcssListHlaA1 (TcssListHlaA1Id, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('32', '679', '5', '11', '11')
	SET IDENTITY_INSERT TcssListHlaA1 OFF
END
GO