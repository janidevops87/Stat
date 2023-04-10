IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCultureResultSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCultureResultSelect'
		DROP Procedure TcssListCultureResultSelect
	END
GO

PRINT 'Creating Procedure TcssListCultureResultSelect'
GO

CREATE PROCEDURE dbo.TcssListCultureResultSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCultureResultSelect
**	Desc: Update Data in table TcssListCultureResult
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcr.TcssListCultureResultId AS ListId,
	tlcr.FieldValue AS FieldValue
FROM dbo.TcssListCultureResult tlcr with (nolock)
WHERE
	(@ListId IS NULL OR tlcr.TcssListCultureResultId = @ListId)
	AND (@FieldValue IS NULL OR tlcr.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlcr.UnosValue = @UnosValue)
ORDER BY tlcr.SortOrder, tlcr.FieldValue
GO

GRANT EXEC ON TcssListCultureResultSelect TO PUBLIC
GO
