/***************************************************************************************************
**	Name: TcssListUrinalysisGlucose
**	Desc: Data Load for table TcssListUrinalysisGlucose
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisGlucose ON

IF ((SELECT count(*) FROM TcssListUrinalysisGlucose) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisGlucose (TcssListUrinalysisGlucoseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisGlucose (TcssListUrinalysisGlucoseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisGlucose OFF
GO
