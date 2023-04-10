/***************************************************************************************************
**	Name: TcssListUrinalysisProtein
**	Desc: Data Load for table TcssListUrinalysisProtein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListUrinalysisProtein ON

IF ((SELECT count(*) FROM TcssListUrinalysisProtein) = 0)
BEGIN
	INSERT INTO TcssListUrinalysisProtein (TcssListUrinalysisProteinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Positive', 'Positive')
	INSERT INTO TcssListUrinalysisProtein (TcssListUrinalysisProteinId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Negative', 'Negative')
END

SET IDENTITY_INSERT TcssListUrinalysisProtein OFF
GO
