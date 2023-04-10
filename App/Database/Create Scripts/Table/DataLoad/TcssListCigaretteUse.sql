/***************************************************************************************************
**	Name: TcssListCigaretteUse
**	Desc: Data Load for table TcssListCigaretteUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCigaretteUse ON

IF ((SELECT count(*) FROM TcssListCigaretteUse) = 0)
BEGIN
	INSERT INTO TcssListCigaretteUse (TcssListCigaretteUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListCigaretteUse (TcssListCigaretteUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListCigaretteUse (TcssListCigaretteUseId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListCigaretteUse OFF
GO
