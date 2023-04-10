/***************************************************************************************************
**	Name: TcssListUrinalysisBlood
**	Desc: Data Load for table TcssListUrinalysisBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisBlood ON

IF ((SELECT count(*) FROM TcssListUrinalysisBlood) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisBlood (TcssListUrinalysisBloodId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisBlood (TcssListUrinalysisBloodId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisBlood OFF
GO
