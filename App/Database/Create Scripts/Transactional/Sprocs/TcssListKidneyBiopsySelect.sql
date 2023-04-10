IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyBiopsySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyBiopsySelect'
		DROP Procedure TcssListKidneyBiopsySelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyBiopsySelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyBiopsySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyBiopsySelect
**	Desc: Update Data in table TcssListKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkb.TcssListKidneyBiopsyId AS ListId,
	tlkb.FieldValue AS FieldValue
FROM dbo.TcssListKidneyBiopsy tlkb with (nolock)
WHERE
	(@ListId IS NULL OR tlkb.TcssListKidneyBiopsyId = @ListId)
	AND (@FieldValue IS NULL OR tlkb.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkb.UnosValue = @UnosValue)
ORDER BY tlkb.SortOrder, tlkb.FieldValue
GO

GRANT EXEC ON TcssListKidneyBiopsySelect TO PUBLIC
GO
