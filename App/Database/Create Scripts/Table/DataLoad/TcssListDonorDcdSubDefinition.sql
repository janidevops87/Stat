/***************************************************************************************************
**	Name: TcssListDonorDcdSubDefinition
**	Desc: Data Load for table TcssListDonorDcdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDonorDcdSubDefinition ON

IF ((SELECT count(*) FROM TcssListDonorDcdSubDefinition) = 0)
BEGIN
	INSERT INTO TcssListDonorDcdSubDefinition (TcssListDonorDcdSubDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDonorDcdSubDefinition (TcssListDonorDcdSubDefinitionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListDonorDcdSubDefinition OFF
GO
