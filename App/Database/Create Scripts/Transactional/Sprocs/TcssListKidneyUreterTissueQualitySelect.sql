IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyUreterTissueQualitySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyUreterTissueQualitySelect'
		DROP Procedure TcssListKidneyUreterTissueQualitySelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyUreterTissueQualitySelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyUreterTissueQualitySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyUreterTissueQualitySelect
**	Desc: Update Data in table TcssListKidneyUreterTissueQuality
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkutq.TcssListKidneyUreterTissueQualityId AS ListId,
	tlkutq.FieldValue AS FieldValue
FROM dbo.TcssListKidneyUreterTissueQuality tlkutq with (nolock)
WHERE
	(@ListId IS NULL OR tlkutq.TcssListKidneyUreterTissueQualityId = @ListId)
	AND (@FieldValue IS NULL OR tlkutq.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkutq.UnosValue = @UnosValue)
ORDER BY tlkutq.SortOrder, tlkutq.FieldValue
GO

GRANT EXEC ON TcssListKidneyUreterTissueQualitySelect TO PUBLIC
GO
