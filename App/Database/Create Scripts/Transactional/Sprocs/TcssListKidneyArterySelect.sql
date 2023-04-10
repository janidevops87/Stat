IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyArterySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyArterySelect'
		DROP Procedure TcssListKidneyArterySelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyArterySelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyArterySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyArterySelect
**	Desc: Update Data in table TcssListKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlka.TcssListKidneyArteryId AS ListId,
	tlka.FieldValue AS FieldValue
FROM dbo.TcssListKidneyArtery tlka with (nolock)
WHERE
	(@ListId IS NULL OR tlka.TcssListKidneyArteryId = @ListId)
	AND (@FieldValue IS NULL OR tlka.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlka.UnosValue = @UnosValue)
ORDER BY tlka.SortOrder, tlka.FieldValue
GO

GRANT EXEC ON TcssListKidneyArterySelect TO PUBLIC
GO
