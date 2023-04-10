/***************************************************************************************************
**	Name: TcssListDonorMeetCdcGuidelines
**	Desc: Data Load for table TcssListDonorMeetCdcGuidelines
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListDonorMeetCdcGuidelines ON

IF ((SELECT count(*) FROM TcssListDonorMeetCdcGuidelines) = 0)
BEGIN
	INSERT INTO TcssListDonorMeetCdcGuidelines (TcssListDonorMeetCdcGuidelinesId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListDonorMeetCdcGuidelines (TcssListDonorMeetCdcGuidelinesId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListDonorMeetCdcGuidelines (TcssListDonorMeetCdcGuidelinesId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListDonorMeetCdcGuidelines OFF
GO
