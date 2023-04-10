IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyHorseshoeShapeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyHorseshoeShapeSelect'
		DROP Procedure TcssListKidneyHorseshoeShapeSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyHorseshoeShapeSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyHorseshoeShapeSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyHorseshoeShapeSelect
**	Desc: Update Data in table TcssListKidneyHorseshoeShape
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkhs.TcssListKidneyHorseshoeShapeId AS ListId,
	tlkhs.FieldValue AS FieldValue
FROM dbo.TcssListKidneyHorseshoeShape tlkhs with (nolock)
WHERE
	(@ListId IS NULL OR tlkhs.TcssListKidneyHorseshoeShapeId = @ListId)
	AND (@FieldValue IS NULL OR tlkhs.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkhs.UnosValue = @UnosValue)
ORDER BY tlkhs.SortOrder, tlkhs.FieldValue
GO

GRANT EXEC ON TcssListKidneyHorseshoeShapeSelect TO PUBLIC
GO
