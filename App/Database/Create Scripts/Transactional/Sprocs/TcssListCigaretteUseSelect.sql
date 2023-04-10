IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCigaretteUseSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCigaretteUseSelect'
		DROP Procedure TcssListCigaretteUseSelect
	END
GO

PRINT 'Creating Procedure TcssListCigaretteUseSelect'
GO

CREATE PROCEDURE dbo.TcssListCigaretteUseSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCigaretteUseSelect
**	Desc: Update Data in table TcssListCigaretteUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcu.TcssListCigaretteUseId AS ListId,
	tlcu.FieldValue AS FieldValue
FROM dbo.TcssListCigaretteUse tlcu with (nolock)
WHERE
	(@ListId IS NULL OR tlcu.TcssListCigaretteUseId = @ListId)
	AND (@FieldValue IS NULL OR tlcu.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlcu.UnosValue = @UnosValue)
ORDER BY tlcu.SortOrder, tlcu.FieldValue
GO

GRANT EXEC ON TcssListCigaretteUseSelect TO PUBLIC
GO
