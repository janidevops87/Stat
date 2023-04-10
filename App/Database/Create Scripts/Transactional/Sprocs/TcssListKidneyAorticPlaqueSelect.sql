IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyAorticPlaqueSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyAorticPlaqueSelect'
		DROP Procedure TcssListKidneyAorticPlaqueSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyAorticPlaqueSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyAorticPlaqueSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyAorticPlaqueSelect
**	Desc: Update Data in table TcssListKidneyAorticPlaque
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkap.TcssListKidneyAorticPlaqueId AS ListId,
	tlkap.FieldValue AS FieldValue
FROM dbo.TcssListKidneyAorticPlaque tlkap with (nolock)
WHERE
	(@ListId IS NULL OR tlkap.TcssListKidneyAorticPlaqueId = @ListId)
	AND (@FieldValue IS NULL OR tlkap.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkap.UnosValue = @UnosValue)
ORDER BY tlkap.SortOrder, tlkap.FieldValue
GO

GRANT EXEC ON TcssListKidneyAorticPlaqueSelect TO PUBLIC
GO
