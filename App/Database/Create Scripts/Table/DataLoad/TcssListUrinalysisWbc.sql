/***************************************************************************************************
**	Name: TcssListUrinalysisWbc
**	Desc: Data Load for table TcssListUrinalysisWbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisWbc ON

IF ((SELECT count(*) FROM TcssListUrinalysisWbc) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisWbc (TcssListUrinalysisWbcId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisWbc (TcssListUrinalysisWbcId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisWbc OFF
GO
