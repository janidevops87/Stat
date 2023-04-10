/***************************************************************************************************
**	Name: TcssListArginineVasopressin
**	Desc: Data Load for table TcssListArginineVasopressin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListArginineVasopressin ON

IF ((SELECT count(*) FROM TcssListArginineVasopressin) = 0)
BEGIN
	INSERT INTO TcssListArginineVasopressin (TcssListArginineVasopressinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListArginineVasopressin (TcssListArginineVasopressinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListArginineVasopressin OFF
GO
