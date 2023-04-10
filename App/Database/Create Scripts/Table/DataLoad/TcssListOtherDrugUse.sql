/***************************************************************************************************
**	Name: TcssListOtherDrugUse
**	Desc: Data Load for table TcssListOtherDrugUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListOtherDrugUse ON

IF ((SELECT count(*) FROM TcssListOtherDrugUse) = 0)
BEGIN
	INSERT INTO TcssListOtherDrugUse (TcssListOtherDrugUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListOtherDrugUse (TcssListOtherDrugUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListOtherDrugUse (TcssListOtherDrugUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListOtherDrugUse OFF
GO
