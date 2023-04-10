/***************************************************************************************************
**	Name: TcssListDonorMeetsDcdCriteria
**	Desc: Data Load for table TcssListDonorMeetsDcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDonorMeetsDcdCriteria ON

IF ((SELECT count(*) FROM TcssListDonorMeetsDcdCriteria) = 0)
BEGIN
	INSERT INTO TcssListDonorMeetsDcdCriteria (TcssListDonorMeetsDcdCriteriaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDonorMeetsDcdCriteria (TcssListDonorMeetsDcdCriteriaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListDonorMeetsDcdCriteria OFF
GO
