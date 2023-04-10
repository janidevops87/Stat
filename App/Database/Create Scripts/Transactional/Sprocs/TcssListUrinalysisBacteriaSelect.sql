IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisBacteriaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisBacteriaSelect'
		DROP Procedure TcssListUrinalysisBacteriaSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisBacteriaSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisBacteriaSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisBacteriaSelect
**	Desc: Update Data in table TcssListUrinalysisBacteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlub.TcssListUrinalysisBacteriaId AS ListId,
	tlub.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisBacteria tlub with (nolock)
WHERE
	(@ListId IS NULL OR tlub.TcssListUrinalysisBacteriaId = @ListId)
	AND (@FieldValue IS NULL OR tlub.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlub.UnosValue = @UnosValue)
ORDER BY tlub.SortOrder, tlub.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisBacteriaSelect TO PUBLIC
GO
