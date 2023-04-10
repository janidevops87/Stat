IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListLiverBiopsySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListLiverBiopsySelect'
		DROP Procedure TcssListLiverBiopsySelect
	END
GO

PRINT 'Creating Procedure TcssListLiverBiopsySelect'
GO

CREATE PROCEDURE dbo.TcssListLiverBiopsySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListLiverBiopsySelect
**	Desc: Update Data in table TcssListLiverBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tllb.TcssListLiverBiopsyId AS ListId,
	tllb.FieldValue AS FieldValue
FROM dbo.TcssListLiverBiopsy tllb with (nolock)
WHERE
	(@ListId IS NULL OR tllb.TcssListLiverBiopsyId = @ListId)
	AND (@FieldValue IS NULL OR tllb.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tllb.UnosValue = @UnosValue)
ORDER BY tllb.SortOrder, tllb.FieldValue
GO

GRANT EXEC ON TcssListLiverBiopsySelect TO PUBLIC
GO
