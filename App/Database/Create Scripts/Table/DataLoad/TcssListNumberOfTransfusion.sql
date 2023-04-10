/***************************************************************************************************
**	Name: TcssListNumberOfTransfusion
**	Desc: Data Load for table TcssListNumberOfTransfusion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListNumberOfTransfusion ON

IF ((SELECT count(*) FROM TcssListNumberOfTransfusion) = 0)
BEGIN
	INSERT INTO TcssListNumberOfTransfusion (TcssListNumberOfTransfusionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'None', 'None')
	INSERT INTO TcssListNumberOfTransfusion (TcssListNumberOfTransfusionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', '1 - 5', '1 - 5')
	INSERT INTO TcssListNumberOfTransfusion (TcssListNumberOfTransfusionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', '6 - 10', '6 - 10')
	INSERT INTO TcssListNumberOfTransfusion (TcssListNumberOfTransfusionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Greater than 10', 'Greater than 10')
	INSERT INTO TcssListNumberOfTransfusion (TcssListNumberOfTransfusionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Unknown', 'Unknown')
END
UPDATE TcssListNumberOfTransfusion SET UnosValue = 'NONE PRBC and whole' WHERE TcssListNumberOfTransfusionId = 1 
UPDATE TcssListNumberOfTransfusion SET UnosValue = '1 - 5 PRBC and whole' WHERE TcssListNumberOfTransfusionId = 2
SET IDENTITY_INSERT TcssListNumberOfTransfusion OFF
GO
