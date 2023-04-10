/***************************************************************************************************
**	Name: TcssListKidneyAorticCuff
**	Desc: Data Load for table TcssListKidneyAorticCuff
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyAorticCuff ON

IF ((SELECT count(*) FROM TcssListKidneyAorticCuff) = 0)
BEGIN
	INSERT INTO TcssListKidneyAorticCuff (TcssListKidneyAorticCuffId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyAorticCuff (TcssListKidneyAorticCuffId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyAorticCuff OFF
GO
