/***************************************************************************************************
**	Name: TcssListKidneyUreterTissueQuality
**	Desc: Data Load for table TcssListKidneyUreterTissueQuality
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyUreterTissueQuality ON

IF ((SELECT count(*) FROM TcssListKidneyUreterTissueQuality) = 0)
BEGIN
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Cardioplege', 'Cardioplege')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Celsior', 'Celsior')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Custodiol', 'Custodiol')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'EuroCollins', 'EuroCollins')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Modified Collins', 'Collins')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'No Flush', 'No Flush')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Other (specify)', 'Other (specify)')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('8', '679', '8', 'Perfadex', 'Perfadex')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('9', '679', '9', 'Pulmoplege', 'Pulmoplege')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('10', '679', '10', 'Ringers', 'Ringers')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('11', '679', '11', 'Saline', 'Saline')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('12', '679', '12', 'Unknown', 'Unknown')
	INSERT INTO TcssListKidneyUreterTissueQuality (TcssListKidneyUreterTissueQualityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('13', '679', '13', 'Viaspan (UW/Belzer)', 'Viaspan (UW/Belzer)')
END

SET IDENTITY_INSERT TcssListKidneyUreterTissueQuality OFF
GO
