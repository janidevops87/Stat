/***************************************************************************************************
**	Name: TcssListOrganType
**	Desc: Data Load for table TcssListOrganType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListOrganType ON
IF ((SELECT count(*) FROM TcssListOrganType) = 0)
BEGIN
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Liver', 'Liver')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Kidney', 'Kidney')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Heart', 'Heart')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Lung', 'Lung')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Intestine', 'Intestine')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'Pancreas', 'Pancreas')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'HeartLung', 'Heart/Lung')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'KidneyPancreas', 'Kidney/Pancreas')
	INSERT INTO TcssListOrganType (TcssListOrganTypeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'MultiOrgan', 'Multi Organ')
END
SET IDENTITY_INSERT TcssListOrganType OFF
GO

