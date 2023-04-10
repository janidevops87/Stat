IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyUreterSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyUreterSelect'
		DROP Procedure TcssListKidneyUreterSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyUreterSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyUreterSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyUreterSelect
**	Desc: Update Data in table TcssListKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlku.TcssListKidneyUreterId AS ListId,
	tlku.FieldValue AS FieldValue
FROM dbo.TcssListKidneyUreter tlku with (nolock)
WHERE
	(@ListId IS NULL OR tlku.TcssListKidneyUreterId = @ListId)
	AND (@FieldValue IS NULL OR tlku.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlku.UnosValue = @UnosValue)
ORDER BY tlku.SortOrder, tlku.FieldValue
GO

GRANT EXEC ON TcssListKidneyUreterSelect TO PUBLIC
GO
