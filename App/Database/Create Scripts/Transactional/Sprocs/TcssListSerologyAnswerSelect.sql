IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListSerologyAnswerSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListSerologyAnswerSelect'
		DROP Procedure TcssListSerologyAnswerSelect
	END
GO

PRINT 'Creating Procedure TcssListSerologyAnswerSelect'
GO

CREATE PROCEDURE dbo.TcssListSerologyAnswerSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListSerologyAnswerSelect
**	Desc: Update Data in table TcssListSerologyAnswer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlsa.TcssListSerologyAnswerId AS ListId,
	tlsa.FieldValue AS FieldValue
FROM dbo.TcssListSerologyAnswer tlsa with (nolock)
WHERE
	(@ListId IS NULL OR tlsa.TcssListSerologyAnswerId = @ListId)
	AND (@FieldValue IS NULL OR tlsa.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlsa.UnosValue = @UnosValue)
ORDER BY tlsa.SortOrder, tlsa.FieldValue
GO

GRANT EXEC ON TcssListSerologyAnswerSelect TO PUBLIC
GO
