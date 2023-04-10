/***************************************************************************************************
**	Name: TcssListRefusedByOtherCenter
**	Desc: Data Load for table TcssListRefusedByOtherCenter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListRefusedByOtherCenter ON

IF ((SELECT count(*) FROM TcssListRefusedByOtherCenter) = 0)
BEGIN
	INSERT INTO TcssListRefusedByOtherCenter (TcssListRefusedByOtherCenterId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListRefusedByOtherCenter (TcssListRefusedByOtherCenterId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListRefusedByOtherCenter (TcssListRefusedByOtherCenterId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'N/A', 'N/A')
END

SET IDENTITY_INSERT TcssListRefusedByOtherCenter OFF
GO
