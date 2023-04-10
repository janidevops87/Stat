/***************************************************************************************************
**	Name: TcssListTotalParenteralNutrition
**	Desc: Creates new table TcssListTotalParenteralNutrition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	5/11		jth				Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListTotalParenteralNutrition')
BEGIN
	-- DROP TABLE dbo.TcssListTotalParenteralNutrition
	PRINT 'TcssListTotalParenteralNutrition'
	CREATE TABLE dbo.TcssListTotalParenteralNutrition
	(
		TcssListTotalParenteralNutritionId int NOT NULL ,
		LastUpdateStatEmployeeId int  NULL,
		LastUpdateDate datetime  NULL,
		SortOrder int NULL,
		IsActive int  NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL
	)
END
GO

GRANT SELECT ON TcssListTotalParenteralNutrition TO PUBLIC
GO
 