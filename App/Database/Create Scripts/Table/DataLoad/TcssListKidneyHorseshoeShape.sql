/***************************************************************************************************
**	Name: TcssListKidneyHorseshoeShape
**	Desc: Data Load for table TcssListKidneyHorseshoeShape
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListKidneyHorseshoeShape ON

IF ((SELECT count(*) FROM TcssListKidneyHorseshoeShape) = 0)
BEGIN
	INSERT INTO TcssListKidneyHorseshoeShape (TcssListKidneyHorseshoeShapeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Yes')
	INSERT INTO TcssListKidneyHorseshoeShape (TcssListKidneyHorseshoeShapeId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'No')
END

SET IDENTITY_INSERT TcssListKidneyHorseshoeShape OFF
GO
