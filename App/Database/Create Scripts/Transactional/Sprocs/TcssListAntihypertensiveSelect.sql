IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListAntihypertensiveSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListAntihypertensiveSelect'
		DROP Procedure TcssListAntihypertensiveSelect
	END
GO

PRINT 'Creating Procedure TcssListAntihypertensiveSelect'
GO

CREATE PROCEDURE dbo.TcssListAntihypertensiveSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListAntihypertensiveSelect
**	Desc: Update Data in table TcssListAntihypertensive
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tla.TcssListAntihypertensiveId AS ListId,
	tla.FieldValue AS FieldValue
FROM dbo.TcssListAntihypertensive tla with (nolock)
WHERE
	(@ListId IS NULL OR tla.TcssListAntihypertensiveId = @ListId)
	AND (@FieldValue IS NULL OR tla.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tla.UnosValue = @UnosValue)
ORDER BY tla.SortOrder, tla.FieldValue
GO

GRANT EXEC ON TcssListAntihypertensiveSelect TO PUBLIC
GO
