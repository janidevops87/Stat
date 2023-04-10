IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaA2Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaA2Select'
		DROP Procedure TcssListHlaA2Select
	END
GO

PRINT 'Creating Procedure TcssListHlaA2Select'
GO

CREATE PROCEDURE dbo.TcssListHlaA2Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaA2Select
**	Desc: Update Data in table TcssListHlaA2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlha.TcssListHlaA2Id AS ListId,
	tlha.FieldValue AS FieldValue
FROM dbo.TcssListHlaA2 tlha with (nolock)
WHERE
	(@ListId IS NULL OR tlha.TcssListHlaA2Id = @ListId)
	AND (@FieldValue IS NULL OR tlha.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlha.UnosValue = @UnosValue)
ORDER BY tlha.SortOrder, tlha.FieldValue
GO

GRANT EXEC ON TcssListHlaA2Select TO PUBLIC
GO
