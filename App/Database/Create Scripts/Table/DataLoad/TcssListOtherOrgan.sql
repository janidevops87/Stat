/***************************************************************************************************
**	Name: TcssListOtherOrgan
**	Desc: Data Load for table TcssListOtherOrgan
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListOtherOrgan ON

IF ((SELECT count(*) FROM TcssListOtherOrgan) = 0)
BEGIN
	INSERT INTO TcssListOtherOrgan (TcssListOtherOrganId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Heart', 'Heart')
	INSERT INTO TcssListOtherOrgan (TcssListOtherOrganId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Lung', 'Lung')
	INSERT INTO TcssListOtherOrgan (TcssListOtherOrganId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Intestine', 'Intestine')
	INSERT INTO TcssListOtherOrgan (TcssListOtherOrganId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Pancreas', 'Pancreas')
END

SET IDENTITY_INSERT TcssListOtherOrgan OFF
GO
