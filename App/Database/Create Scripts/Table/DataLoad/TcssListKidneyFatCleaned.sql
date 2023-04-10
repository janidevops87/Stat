/***************************************************************************************************
**	Name: TcssListKidneyFatCleaned
**	Desc: Data Load for table TcssListKidneyFatCleaned
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyFatCleaned ON

IF ((SELECT count(*) FROM TcssListKidneyFatCleaned) = 0)
BEGIN
	INSERT INTO TcssListKidneyFatCleaned (TcssListKidneyFatCleanedId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyFatCleaned (TcssListKidneyFatCleanedId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyFatCleaned OFF
GO
