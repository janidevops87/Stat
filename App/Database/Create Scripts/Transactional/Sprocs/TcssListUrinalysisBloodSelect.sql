IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisBloodSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisBloodSelect'
		DROP Procedure TcssListUrinalysisBloodSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisBloodSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisBloodSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisBloodSelect
**	Desc: Update Data in table TcssListUrinalysisBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlub.TcssListUrinalysisBloodId AS ListId,
	tlub.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisBlood tlub with (nolock)
WHERE
	(@ListId IS NULL OR tlub.TcssListUrinalysisBloodId = @ListId)
	AND (@FieldValue IS NULL OR tlub.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlub.UnosValue = @UnosValue)
ORDER BY tlub.SortOrder, tlub.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisBloodSelect TO PUBLIC
GO
