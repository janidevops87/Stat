/***************************************************************************************************
**	Name: TcssListKidneyPumpSolution
**	Desc: Data Load for table TcssListKidneyPumpSolution
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyPumpSolution ON

IF ((SELECT count(*) FROM TcssListKidneyPumpSolution) = 0)
BEGIN
	INSERT INTO TcssListKidneyPumpSolution (TcssListKidneyPumpSolutionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Belzer', 'Belzer')
	INSERT INTO TcssListKidneyPumpSolution (TcssListKidneyPumpSolutionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Silica gel', 'Silica gel')
	INSERT INTO TcssListKidneyPumpSolution (TcssListKidneyPumpSolutionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Other specify', 'Other specify')
END

SET IDENTITY_INSERT TcssListKidneyPumpSolution OFF
GO
