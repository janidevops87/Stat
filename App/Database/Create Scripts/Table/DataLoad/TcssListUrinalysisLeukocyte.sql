/***************************************************************************************************
**	Name: TcssListUrinalysisLeukocyte
**	Desc: Data Load for table TcssListUrinalysisLeukocyte
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisLeukocyte ON

IF ((SELECT count(*) FROM TcssListUrinalysisLeukocyte) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisLeukocyte (TcssListUrinalysisLeukocyteId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisLeukocyte (TcssListUrinalysisLeukocyteId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisLeukocyte OFF
GO
