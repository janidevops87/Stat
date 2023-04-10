IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyFatCleanedSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyFatCleanedSelect'
		DROP Procedure TcssListKidneyFatCleanedSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyFatCleanedSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyFatCleanedSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyFatCleanedSelect
**	Desc: Update Data in table TcssListKidneyFatCleaned
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkfc.TcssListKidneyFatCleanedId AS ListId,
	tlkfc.FieldValue AS FieldValue
FROM dbo.TcssListKidneyFatCleaned tlkfc with (nolock)
WHERE
	(@ListId IS NULL OR tlkfc.TcssListKidneyFatCleanedId = @ListId)
	AND (@FieldValue IS NULL OR tlkfc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkfc.UnosValue = @UnosValue)
ORDER BY tlkfc.SortOrder, tlkfc.FieldValue
GO

GRANT EXEC ON TcssListKidneyFatCleanedSelect TO PUBLIC
GO
