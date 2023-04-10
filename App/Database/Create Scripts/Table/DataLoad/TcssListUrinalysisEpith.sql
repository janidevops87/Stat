/***************************************************************************************************
**	Name: TcssListUrinalysisEpith
**	Desc: Data Load for table TcssListUrinalysisEpith
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisEpith ON

IF ((SELECT count(*) FROM TcssListUrinalysisEpith) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisEpith (TcssListUrinalysisEpithId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisEpith (TcssListUrinalysisEpithId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisEpith OFF
GO
