/***************************************************************************************************
**	Name: TcssListHeavyAlcoholUse
**	Desc: Data Load for table TcssListHeavyAlcoholUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHeavyAlcoholUse ON

IF ((SELECT count(*) FROM TcssListHeavyAlcoholUse) = 0)
BEGIN
	INSERT INTO TcssListHeavyAlcoholUse (TcssListHeavyAlcoholUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListHeavyAlcoholUse (TcssListHeavyAlcoholUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListHeavyAlcoholUse (TcssListHeavyAlcoholUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListHeavyAlcoholUse OFF
GO
