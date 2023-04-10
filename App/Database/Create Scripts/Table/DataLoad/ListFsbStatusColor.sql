/***************************************************************************************************
**	Name: ListFsbStatusColor
**	Desc: Data Load for table ListFsbStatusColor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT ListFsbStatusColor ON

IF ((SELECT count(*) FROM ListFsbStatusColor) = 0)
BEGIN
	INSERT INTO ListFsbStatusColor (ListFsbStatusColorId, LastStatEmployeeId, FieldValue) VALUES('1', '679', 'Normal')
	INSERT INTO ListFsbStatusColor (ListFsbStatusColorId, LastStatEmployeeId, FieldValue) VALUES('2', '679', 'Red')
END

SET IDENTITY_INSERT ListFsbStatusColor OFF
GO
