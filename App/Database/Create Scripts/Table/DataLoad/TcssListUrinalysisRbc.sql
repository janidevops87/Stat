/***************************************************************************************************
**	Name: TcssListUrinalysisRbc
**	Desc: Data Load for table TcssListUrinalysisRbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisRbc ON

IF ((SELECT count(*) FROM TcssListUrinalysisRbc) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisRbc (TcssListUrinalysisRbcId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisRbc (TcssListUrinalysisRbcId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisRbc OFF
GO
