IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisLeukocyteSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisLeukocyteSelect'
		DROP Procedure TcssListUrinalysisLeukocyteSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisLeukocyteSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisLeukocyteSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisLeukocyteSelect
**	Desc: Update Data in table TcssListUrinalysisLeukocyte
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlul.TcssListUrinalysisLeukocyteId AS ListId,
	tlul.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisLeukocyte tlul with (nolock)
WHERE
	(@ListId IS NULL OR tlul.TcssListUrinalysisLeukocyteId = @ListId)
	AND (@FieldValue IS NULL OR tlul.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlul.UnosValue = @UnosValue)
ORDER BY tlul.SortOrder, tlul.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisLeukocyteSelect TO PUBLIC
GO
