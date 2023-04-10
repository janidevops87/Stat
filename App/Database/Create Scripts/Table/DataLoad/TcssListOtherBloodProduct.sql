/***************************************************************************************************
**	Name: TcssListOtherBloodProduct
**	Desc: Data Load for table TcssListOtherBloodProduct
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListOtherBloodProduct ON

IF ((SELECT count(*) FROM TcssListOtherBloodProduct) = 0)
BEGIN
	INSERT INTO TcssListOtherBloodProduct (TcssListOtherBloodProductId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListOtherBloodProduct (TcssListOtherBloodProductId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

UPDATE TcssListOtherBloodProduct SET UnosValue = 'Y' WHERE TcssListOtherBloodProductId = 1
UPDATE TcssListOtherBloodProduct SET UnosValue = 'N' WHERE TcssListOtherBloodProductId = 2

SET IDENTITY_INSERT TcssListOtherBloodProduct OFF
GO
