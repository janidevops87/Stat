IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaA1Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaA1Select'
		DROP Procedure TcssListHlaA1Select
	END
GO

PRINT 'Creating Procedure TcssListHlaA1Select'
GO

CREATE PROCEDURE dbo.TcssListHlaA1Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaA1Select
**	Desc: Update Data in table TcssListHlaA1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlha.TcssListHlaA1Id AS ListId,
	tlha.FieldValue AS FieldValue
FROM dbo.TcssListHlaA1 tlha with (nolock)
WHERE
	(@ListId IS NULL OR tlha.TcssListHlaA1Id = @ListId)
	AND (@FieldValue IS NULL OR tlha.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlha.UnosValue = @UnosValue)
ORDER BY tlha.SortOrder, tlha.FieldValue
GO

GRANT EXEC ON TcssListHlaA1Select TO PUBLIC
GO
