/***************************************************************************************************
**	Name: TcssListChestTrauma
**	Desc: Data Load for table TcssListChestTrauma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListChestTrauma ON

IF ((SELECT count(*) FROM TcssListChestTrauma) = 0)
BEGIN
	INSERT INTO TcssListChestTrauma (TcssListChestTraumaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListChestTrauma (TcssListChestTraumaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListChestTrauma (TcssListChestTraumaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListChestTrauma OFF
GO
