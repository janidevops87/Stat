/***************************************************************************************************
**	Name: TcssListDonorDbdSubDefinition
**	Desc: Data Load for table TcssListDonorDbdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDonorDbdSubDefinition ON

IF ((SELECT count(*) FROM TcssListDonorDbdSubDefinition) = 0)
BEGIN
	INSERT INTO TcssListDonorDbdSubDefinition (TcssListDonorDbdSubDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'SCD', 'SCD')
	INSERT INTO TcssListDonorDbdSubDefinition (TcssListDonorDbdSubDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'ECD', 'ECD')
	INSERT INTO TcssListDonorDbdSubDefinition (TcssListDonorDbdSubDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListDonorDbdSubDefinition OFF
GO
