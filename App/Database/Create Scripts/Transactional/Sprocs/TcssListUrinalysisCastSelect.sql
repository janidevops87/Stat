IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisCastSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisCastSelect'
		DROP Procedure TcssListUrinalysisCastSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisCastSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisCastSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisCastSelect
**	Desc: Update Data in table TcssListUrinalysisCast
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tluc.TcssListUrinalysisCastId AS ListId,
	tluc.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisCast tluc with (nolock)
WHERE
	(@ListId IS NULL OR tluc.TcssListUrinalysisCastId = @ListId)
	AND (@FieldValue IS NULL OR tluc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tluc.UnosValue = @UnosValue)
ORDER BY tluc.SortOrder, tluc.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisCastSelect TO PUBLIC
GO
