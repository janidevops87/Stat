IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisRbcSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisRbcSelect'
		DROP Procedure TcssListUrinalysisRbcSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisRbcSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisRbcSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisRbcSelect
**	Desc: Update Data in table TcssListUrinalysisRbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlur.TcssListUrinalysisRbcId AS ListId,
	tlur.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisRbc tlur with (nolock)
WHERE
	(@ListId IS NULL OR tlur.TcssListUrinalysisRbcId = @ListId)
	AND (@FieldValue IS NULL OR tlur.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlur.UnosValue = @UnosValue)
ORDER BY tlur.SortOrder, tlur.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisRbcSelect TO PUBLIC
GO
