/***************************************************************************************************
**	Name: TcssListAntihypertensive
**	Desc: Data Load for table TcssListAntihypertensive
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListAntihypertensive ON

IF ((SELECT count(*) FROM TcssListAntihypertensive) = 0)
BEGIN
	INSERT INTO TcssListAntihypertensive (TcssListAntihypertensiveId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListAntihypertensive (TcssListAntihypertensiveId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListAntihypertensive OFF
GO
