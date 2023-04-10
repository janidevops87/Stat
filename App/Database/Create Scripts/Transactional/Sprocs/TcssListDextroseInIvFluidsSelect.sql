IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDextroseInIvFluidsSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDextroseInIvFluidsSelect'
		DROP Procedure TcssListDextroseInIvFluidsSelect
	END
GO

PRINT 'Creating Procedure TcssListDextroseInIvFluidsSelect'
GO

CREATE PROCEDURE dbo.TcssListDextroseInIvFluidsSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDextroseInIvFluidsSelect
**	Desc: Update Data in table TcssListDextroseInIvFluids
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldiif.TcssListDextroseInIvFluidsId AS ListId,
	tldiif.FieldValue AS FieldValue
FROM dbo.TcssListDextroseInIvFluids tldiif with (nolock)
WHERE
	(@ListId IS NULL OR tldiif.TcssListDextroseInIvFluidsId = @ListId)
	AND (@FieldValue IS NULL OR tldiif.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tldiif.UnosValue = @UnosValue)
ORDER BY tldiif.SortOrder, tldiif.FieldValue
GO

GRANT EXEC ON TcssListDextroseInIvFluidsSelect TO PUBLIC
GO
