/***************************************************************************************************
**	Name: TcssListDextroseInIvFluids
**	Desc: Data Load for table TcssListDextroseInIvFluids
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDextroseInIvFluids ON

IF ((SELECT count(*) FROM TcssListDextroseInIvFluids) = 0)
BEGIN
	INSERT INTO TcssListDextroseInIvFluids (TcssListDextroseInIvFluidsId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDextroseInIvFluids (TcssListDextroseInIvFluidsId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListDextroseInIvFluids (TcssListDextroseInIvFluidsId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListDextroseInIvFluids OFF
GO
