/***************************************************************************************************
**	Name: TcssListUrinalysisCast
**	Desc: Data Load for table TcssListUrinalysisCast
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisCast ON

IF ((SELECT count(*) FROM TcssListUrinalysisCast) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisCast (TcssListUrinalysisCastId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisCast (TcssListUrinalysisCastId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisCast OFF
GO
