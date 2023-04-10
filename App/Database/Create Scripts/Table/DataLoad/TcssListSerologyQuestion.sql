/***************************************************************************************************
**	Name: TcssListSerologyQuestion
**	Desc: Data Load for table TcssListSerologyQuestion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListSerologyQuestion ON

IF ((SELECT count(*) FROM TcssListSerologyQuestion) = 0)
BEGIN
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Anti-HBcAb', 'Anti-HBcAb')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Anti-HCV', 'Anti-HCV')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Anti-HIV I/II:', 'Anti-HIV I/II')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Anti-HTLV I/II:', 'Anti-HTLV I/II')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'HBsAg', 'HBsAg')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Anti-CMV', 'Anti-CMV')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'RPR/VDRL', 'RPR/VDRL')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'HBsAb', 'HBsAb')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'EBV (VCA) (lgG)', 'EBV (VCA) (lgG)')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', 'EBV (VCA) (lgM)', 'EBV (VCA) (lgM)')
	INSERT INTO TcssListSerologyQuestion (TcssListSerologyQuestionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', 'EBNA', 'EBNA')
END

SET IDENTITY_INSERT TcssListSerologyQuestion OFF
GO
