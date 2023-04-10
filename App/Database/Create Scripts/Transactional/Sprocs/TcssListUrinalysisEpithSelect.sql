IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisEpithSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisEpithSelect'
		DROP Procedure TcssListUrinalysisEpithSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisEpithSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisEpithSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisEpithSelect
**	Desc: Update Data in table TcssListUrinalysisEpith
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlue.TcssListUrinalysisEpithId AS ListId,
	tlue.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisEpith tlue with (nolock)
WHERE
	(@ListId IS NULL OR tlue.TcssListUrinalysisEpithId = @ListId)
	AND (@FieldValue IS NULL OR tlue.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlue.UnosValue = @UnosValue)
ORDER BY tlue.SortOrder, tlue.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisEpithSelect TO PUBLIC
GO
