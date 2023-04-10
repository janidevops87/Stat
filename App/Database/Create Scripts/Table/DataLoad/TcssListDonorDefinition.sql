/***************************************************************************************************
**	Name: TcssListDonorDefinition
**	Desc: Data Load for table TcssListDonorDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDonorDefinition ON

IF ((SELECT count(*) FROM TcssListDonorDefinition) = 0)
BEGIN
	INSERT INTO TcssListDonorDefinition (TcssListDonorDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'DBD (Brain Death)', 'DBD (Brain Death)')
	INSERT INTO TcssListDonorDefinition (TcssListDonorDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'DCD', 'DCD')
	INSERT INTO TcssListDonorDefinition (TcssListDonorDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListDonorDefinition OFF
GO
