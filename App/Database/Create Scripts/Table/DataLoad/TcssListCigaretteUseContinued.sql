/***************************************************************************************************
**	Name: TcssListCigaretteUseContinued
**	Desc: Data Load for table TcssListCigaretteUseContinued
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCigaretteUseContinued ON

IF ((SELECT count(*) FROM TcssListCigaretteUseContinued) = 0)
BEGIN
	INSERT INTO TcssListCigaretteUseContinued (TcssListCigaretteUseContinuedId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListCigaretteUseContinued (TcssListCigaretteUseContinuedId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListCigaretteUseContinued (TcssListCigaretteUseContinuedId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListCigaretteUseContinued OFF
GO
