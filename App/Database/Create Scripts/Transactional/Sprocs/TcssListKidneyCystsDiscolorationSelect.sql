IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyCystsDiscolorationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyCystsDiscolorationSelect'
		DROP Procedure TcssListKidneyCystsDiscolorationSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyCystsDiscolorationSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyCystsDiscolorationSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyCystsDiscolorationSelect
**	Desc: Update Data in table TcssListKidneyCystsDiscoloration
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkcd.TcssListKidneyCystsDiscolorationId AS ListId,
	tlkcd.FieldValue AS FieldValue
FROM dbo.TcssListKidneyCystsDiscoloration tlkcd with (nolock)
WHERE
	(@ListId IS NULL OR tlkcd.TcssListKidneyCystsDiscolorationId = @ListId)
	AND (@FieldValue IS NULL OR tlkcd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkcd.UnosValue = @UnosValue)
ORDER BY tlkcd.SortOrder, tlkcd.FieldValue
GO

GRANT EXEC ON TcssListKidneyCystsDiscolorationSelect TO PUBLIC
GO
