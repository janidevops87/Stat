/***************************************************************************************************
**	Name: TcssListHeparin
**	Desc: Data Load for table TcssListHeparin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	11/11/2010	jth				Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListHeparin ON

IF ((SELECT count(*) FROM TcssListHeparin) = 0)
BEGIN
	INSERT INTO TcssListHeparin (TcssListHeparinId, LastUpdateStatEmployeeId,LastUpdateDate, SortOrder,IsActive, FieldValue, UnosValue) VALUES('1', '1499',(getutcdate()), '1','1', 'Yes', 'Yes')
	INSERT INTO TcssListHeparin (TcssListHeparinId, LastUpdateStatEmployeeId,LastUpdateDate, SortOrder,IsActive, FieldValue, UnosValue) VALUES('2', '1499',(getutcdate()), '2','1', 'No', 'No')
END

SET IDENTITY_INSERT TcssListHeparin OFF
GO
