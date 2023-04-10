/***************************************************************************************************
**	Name: TcssListStatusOfImportData
**	Desc: Data Load for table TcssListStatusOfImportData
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListStatusOfImportData ON

IF ((SELECT count(*) FROM TcssListStatusOfImportData) = 0)
BEGIN
	INSERT INTO TcssListStatusOfImportData (TcssListStatusOfImportDataId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Donor Card Data Sufficient', 'Donor Card Data Sufficient')
	INSERT INTO TcssListStatusOfImportData (TcssListStatusOfImportDataId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Donor Card Data Insufficient', 'Donor Card Data Insufficient')
END

SET IDENTITY_INSERT TcssListStatusOfImportData OFF
GO
