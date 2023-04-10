IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneySubcapsularSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneySubcapsularSelect'
		DROP Procedure TcssListKidneySubcapsularSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneySubcapsularSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneySubcapsularSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneySubcapsularSelect
**	Desc: Update Data in table TcssListKidneySubcapsular
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlks.TcssListKidneySubcapsularId AS ListId,
	tlks.FieldValue AS FieldValue
FROM dbo.TcssListKidneySubcapsular tlks with (nolock)
WHERE
	(@ListId IS NULL OR tlks.TcssListKidneySubcapsularId = @ListId)
	AND (@FieldValue IS NULL OR tlks.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlks.UnosValue = @UnosValue)
ORDER BY tlks.SortOrder, tlks.FieldValue
GO

GRANT EXEC ON TcssListKidneySubcapsularSelect TO PUBLIC
GO
