IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListOtherBloodProductSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListOtherBloodProductSelect'
		DROP Procedure TcssListOtherBloodProductSelect
	END
GO

PRINT 'Creating Procedure TcssListOtherBloodProductSelect'
GO

CREATE PROCEDURE dbo.TcssListOtherBloodProductSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListOtherBloodProductSelect
**	Desc: Update Data in table TcssListOtherBloodProduct
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlobp.TcssListOtherBloodProductId AS ListId,
	tlobp.FieldValue AS FieldValue
FROM dbo.TcssListOtherBloodProduct tlobp with (nolock)
WHERE
	(@ListId IS NULL OR tlobp.TcssListOtherBloodProductId = @ListId)
	AND (@FieldValue IS NULL OR tlobp.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlobp.UnosValue = @UnosValue)
ORDER BY tlobp.SortOrder, tlobp.FieldValue
GO

GRANT EXEC ON TcssListOtherBloodProductSelect TO PUBLIC
GO
