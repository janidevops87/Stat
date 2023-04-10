IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisGlucoseSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisGlucoseSelect'
		DROP Procedure TcssListUrinalysisGlucoseSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisGlucoseSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisGlucoseSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisGlucoseSelect
**	Desc: Update Data in table TcssListUrinalysisGlucose
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlug.TcssListUrinalysisGlucoseId AS ListId,
	tlug.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisGlucose tlug with (nolock)
WHERE
	(@ListId IS NULL OR tlug.TcssListUrinalysisGlucoseId = @ListId)
	AND (@FieldValue IS NULL OR tlug.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlug.UnosValue = @UnosValue)
ORDER BY tlug.SortOrder, tlug.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisGlucoseSelect TO PUBLIC
GO
