IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisWbcSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisWbcSelect'
		DROP Procedure TcssListUrinalysisWbcSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisWbcSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisWbcSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisWbcSelect
**	Desc: Update Data in table TcssListUrinalysisWbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tluw.TcssListUrinalysisWbcId AS ListId,
	tluw.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisWbc tluw with (nolock)
WHERE
	(@ListId IS NULL OR tluw.TcssListUrinalysisWbcId = @ListId)
	AND (@FieldValue IS NULL OR tluw.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tluw.UnosValue = @UnosValue)
ORDER BY tluw.SortOrder, tluw.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisWbcSelect TO PUBLIC
GO
