IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCigaretteUseContinuedSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCigaretteUseContinuedSelect'
		DROP Procedure TcssListCigaretteUseContinuedSelect
	END
GO

PRINT 'Creating Procedure TcssListCigaretteUseContinuedSelect'
GO

CREATE PROCEDURE dbo.TcssListCigaretteUseContinuedSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCigaretteUseContinuedSelect
**	Desc: Update Data in table TcssListCigaretteUseContinued
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcuc.TcssListCigaretteUseContinuedId AS ListId,
	tlcuc.FieldValue AS FieldValue
FROM dbo.TcssListCigaretteUseContinued tlcuc with (nolock)
WHERE
	(@ListId IS NULL OR tlcuc.TcssListCigaretteUseContinuedId = @ListId)
	AND (@FieldValue IS NULL OR tlcuc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlcuc.UnosValue = @UnosValue)
ORDER BY tlcuc.SortOrder, tlcuc.FieldValue
GO

GRANT EXEC ON TcssListCigaretteUseContinuedSelect TO PUBLIC
GO
