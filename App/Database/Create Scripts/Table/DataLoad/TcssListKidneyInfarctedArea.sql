/***************************************************************************************************
**	Name: TcssListKidneyInfarctedArea
**	Desc: Data Load for table TcssListKidneyInfarctedArea
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyInfarctedArea ON

IF ((SELECT count(*) FROM TcssListKidneyInfarctedArea) = 0)
BEGIN
	INSERT INTO TcssListKidneyInfarctedArea (TcssListKidneyInfarctedAreaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyInfarctedArea (TcssListKidneyInfarctedAreaId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyInfarctedArea OFF
GO
