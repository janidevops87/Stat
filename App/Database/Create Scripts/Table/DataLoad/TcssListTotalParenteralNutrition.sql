/***************************************************************************************************
**	Name: TcssListTotalParenteralNutrition
**	Desc: Data Load for table TcsListTotalParenteralNutrition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	5/11		jth				Initial Data Load
***************************************************************************************************/

SET IDENTITY_INSERT TcssListTotalParenteralNutrition ON

IF ((SELECT count(*) FROM TcssListTotalParenteralNutrition) = 0)
BEGIN
	INSERT INTO TcssListTotalParenteralNutrition (TcssListTotalParenteralNutritionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('1', '679', '1', 'Yes', 'Y')
	INSERT INTO TcssListTotalParenteralNutrition (TcssListTotalParenteralNutritionId, LastUpdateStatEmployeeId, SortOrder, FieldValue, UnosValue) VALUES('2', '679', '2', 'No', 'N')
	
END

SET IDENTITY_INSERT TcssListTotalParenteralNutrition OFF
GO
 