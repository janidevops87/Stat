/***************************************************************************************************
**	Name: TcssListCardiacArrestDownTime
**	Desc: Data Load for table TcssListCardiacArrestDownTime
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListCardiacArrestDownTime ON

IF ((SELECT count(*) FROM TcssListCardiacArrestDownTime) = 0)
BEGIN
	INSERT INTO TcssListCardiacArrestDownTime (TcssListCardiacArrestDownTimeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListCardiacArrestDownTime (TcssListCardiacArrestDownTimeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
	INSERT INTO TcssListCardiacArrestDownTime (TcssListCardiacArrestDownTimeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('3', '679', '3', 'Unknown', 'Unknown')
END

SET IDENTITY_INSERT TcssListCardiacArrestDownTime OFF
GO
