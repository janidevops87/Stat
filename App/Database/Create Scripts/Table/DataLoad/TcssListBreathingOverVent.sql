/***************************************************************************************************
**	Name: TcssListBreathingOverVent
**	Desc: Data Load for table TcssListBreathingOverVent
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListBreathingOverVent ON

IF ((SELECT count(*) FROM TcssListBreathingOverVent) = 0)
BEGIN
	INSERT INTO TcssListBreathingOverVent (TcssListBreathingOverVentId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListBreathingOverVent (TcssListBreathingOverVentId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'N/A', 'N/A')
	INSERT INTO TcssListBreathingOverVent (TcssListBreathingOverVentId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END
UPDATE TcssListBreathingOverVent SET FieldValue = 'No' WHERE TcssListBreathingOverVentId = 2
UPDATE TcssListBreathingOverVent SET UnosValue = 'No' WHERE TcssListBreathingOverVentId = 2
SET IDENTITY_INSERT TcssListBreathingOverVent OFF
GO
