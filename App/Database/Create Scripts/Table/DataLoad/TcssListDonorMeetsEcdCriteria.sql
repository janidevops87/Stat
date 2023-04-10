/***************************************************************************************************
**	Name: TcssListDonorMeetsEcdCriteria
**	Desc: Data Load for table TcssListDonorMeetsEcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDonorMeetsEcdCriteria ON

IF ((SELECT count(*) FROM TcssListDonorMeetsEcdCriteria) = 0)
BEGIN
	INSERT INTO TcssListDonorMeetsEcdCriteria (TcssListDonorMeetsEcdCriteriaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDonorMeetsEcdCriteria (TcssListDonorMeetsEcdCriteriaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListDonorMeetsEcdCriteria OFF
GO
