IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyHematomaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyHematomaSelect'
		DROP Procedure TcssListKidneyHematomaSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyHematomaSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyHematomaSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyHematomaSelect
**	Desc: Update Data in table TcssListKidneyHematoma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkh.TcssListKidneyHematomaId AS ListId,
	tlkh.FieldValue AS FieldValue
FROM dbo.TcssListKidneyHematoma tlkh with (nolock)
WHERE
	(@ListId IS NULL OR tlkh.TcssListKidneyHematomaId = @ListId)
	AND (@FieldValue IS NULL OR tlkh.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkh.UnosValue = @UnosValue)
ORDER BY tlkh.SortOrder, tlkh.FieldValue
GO

GRANT EXEC ON TcssListKidneyHematomaSelect TO PUBLIC
GO
