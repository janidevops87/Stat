IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListSerologyQuestionSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListSerologyQuestionSelect'
		DROP Procedure TcssListSerologyQuestionSelect
	END
GO

PRINT 'Creating Procedure TcssListSerologyQuestionSelect'
GO

CREATE PROCEDURE dbo.TcssListSerologyQuestionSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListSerologyQuestionSelect
**	Desc: Update Data in table TcssListSerologyQuestion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlsq.TcssListSerologyQuestionId AS ListId,
	tlsq.FieldValue AS FieldValue
FROM dbo.TcssListSerologyQuestion tlsq with (nolock)
WHERE
	(@ListId IS NULL OR tlsq.TcssListSerologyQuestionId = @ListId)
	AND (@FieldValue IS NULL OR tlsq.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlsq.UnosValue = @UnosValue)
ORDER BY tlsq.SortOrder, tlsq.FieldValue
GO

GRANT EXEC ON TcssListSerologyQuestionSelect TO PUBLIC
GO
