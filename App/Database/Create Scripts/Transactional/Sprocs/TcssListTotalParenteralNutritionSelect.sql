IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListTotalParenteralNutritionSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListTotalParenteralNutritionSelect'
		DROP Procedure TcssListTotalParenteralNutritionSelect
	END
GO

PRINT 'Creating Procedure TcssListHeavyAlcoholUseSelect'
GO

CREATE PROCEDURE dbo.TcssListTotalParenteralNutritionSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListTotalParenteralNutritionSelect
**	Desc: Update Data in table TcssListTotalParenteralNutrition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	5/11		jth				Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tpn.TcssListTotalParenteralNutritionId AS ListId,
	tpn.FieldValue AS FieldValue
FROM dbo.TcssListTotalParenteralNutrition tpn with (nolock)
WHERE
	(@ListId IS NULL OR tpn.TcssListTotalParenteralNutritionId = @ListId)
	AND (@FieldValue IS NULL OR tpn.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tpn.UnosValue = @UnosValue)
ORDER BY tpn.SortOrder, tpn.FieldValue
GO

GRANT EXEC ON TcssListTotalParenteralNutritionSelect TO PUBLIC
GO
 