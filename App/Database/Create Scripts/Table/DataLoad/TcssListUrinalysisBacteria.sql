/***************************************************************************************************
**	Name: TcssListUrinalysisBacteria
**	Desc: Data Load for table TcssListUrinalysisBacteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisBacteria ON

IF ((SELECT count(*) FROM TcssListUrinalysisBacteria) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisBacteria (TcssListUrinalysisBacteriaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisBacteria (TcssListUrinalysisBacteriaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisBacteria OFF
GO
