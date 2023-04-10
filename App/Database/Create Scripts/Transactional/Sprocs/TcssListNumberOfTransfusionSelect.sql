IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListNumberOfTransfusionSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListNumberOfTransfusionSelect'
		DROP Procedure TcssListNumberOfTransfusionSelect
	END
GO

PRINT 'Creating Procedure TcssListNumberOfTransfusionSelect'
GO

CREATE PROCEDURE dbo.TcssListNumberOfTransfusionSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListNumberOfTransfusionSelect
**	Desc: Update Data in table TcssListNumberOfTransfusion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlnot.TcssListNumberOfTransfusionId AS ListId,
	tlnot.FieldValue AS FieldValue
FROM dbo.TcssListNumberOfTransfusion tlnot with (nolock)
WHERE
	(@ListId IS NULL OR tlnot.TcssListNumberOfTransfusionId = @ListId)
	AND (@FieldValue IS NULL OR tlnot.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlnot.UnosValue = @UnosValue)
ORDER BY tlnot.SortOrder, tlnot.FieldValue
GO

GRANT EXEC ON TcssListNumberOfTransfusionSelect TO PUBLIC
GO
