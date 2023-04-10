/***************************************************************************************************
**	Name: TcssListCompliantWithTreatment
**	Desc: Data Load for table TcssListCompliantWithTreatment
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCompliantWithTreatment ON

IF ((SELECT count(*) FROM TcssListCompliantWithTreatment) = 0)
BEGIN
	INSERT INTO TcssListCompliantWithTreatment (TcssListCompliantWithTreatmentId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListCompliantWithTreatment (TcssListCompliantWithTreatmentId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListCompliantWithTreatment (TcssListCompliantWithTreatmentId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListCompliantWithTreatment OFF
GO
