IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListUrinalysisProteinSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListUrinalysisProteinSelect'
		DROP Procedure TcssListUrinalysisProteinSelect
	END
GO

PRINT 'Creating Procedure TcssListUrinalysisProteinSelect'
GO

CREATE PROCEDURE dbo.TcssListUrinalysisProteinSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListUrinalysisProteinSelect
**	Desc: Update Data in table TcssListUrinalysisProtein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlup.TcssListUrinalysisProteinId AS ListId,
	tlup.FieldValue AS FieldValue
FROM dbo.TcssListUrinalysisProtein tlup with (nolock)
WHERE
	(@ListId IS NULL OR tlup.TcssListUrinalysisProteinId = @ListId)
	AND (@FieldValue IS NULL OR tlup.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlup.UnosValue = @UnosValue)
ORDER BY tlup.SortOrder, tlup.FieldValue
GO

GRANT EXEC ON TcssListUrinalysisProteinSelect TO PUBLIC
GO
