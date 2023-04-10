/***************************************************************************************************
**	Name: TcssListEthnicity
**	Desc: Data Load for table TcssListEthnicity
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListEthnicity ON

IF ((SELECT count(*) FROM TcssListEthnicity) = 0)
BEGIN
	INSERT INTO TcssListEthnicity (TcssListEthnicityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'American Indian or Alaska Native', 'American Indian or Alaska Native')
	INSERT INTO TcssListEthnicity (TcssListEthnicityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'Asian', 'Asian')
	INSERT INTO TcssListEthnicity (TcssListEthnicityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Black or African American', 'Black or African American')
	INSERT INTO TcssListEthnicity (TcssListEthnicityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'Hispanic/Latino', 'Hispanic/Latino')
	INSERT INTO TcssListEthnicity (TcssListEthnicityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'Native Hawaiian or Other Pacific Islander', 'Native Hawaiian or Other Pacific Islander')
	INSERT INTO TcssListEthnicity (TcssListEthnicityId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'White', 'White')
END

SET IDENTITY_INSERT TcssListEthnicity OFF
GO
