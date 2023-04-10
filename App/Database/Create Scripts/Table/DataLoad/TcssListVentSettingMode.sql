/***************************************************************************************************
**	Name: TcssListVentSettingMode
**	Desc: Data Load for table TcssListVentSettingMode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListVentSettingMode ON

IF ((SELECT count(*) FROM TcssListVentSettingMode) = 0)
BEGIN
	INSERT INTO TcssListVentSettingMode (TcssListVentSettingModeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'NC', 'NC')
	INSERT INTO TcssListVentSettingMode (TcssListVentSettingModeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'CPAP', 'CPAP')
	INSERT INTO TcssListVentSettingMode (TcssListVentSettingModeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'BIPAP', 'BIPAP')
	INSERT INTO TcssListVentSettingMode (TcssListVentSettingModeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('4', '679', '4', 'SIMV', 'SIMV')
	INSERT INTO TcssListVentSettingMode (TcssListVentSettingModeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('5', '679', '5', 'A/C', 'A/C')
	INSERT INTO TcssListVentSettingMode (TcssListVentSettingModeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('6', '679', '6', 'CMV', 'CMV')
	INSERT INTO TcssListVentSettingMode (TcssListVentSettingModeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('7', '679', '7', 'Other', 'Other')
END

SET IDENTITY_INSERT TcssListVentSettingMode OFF
GO
