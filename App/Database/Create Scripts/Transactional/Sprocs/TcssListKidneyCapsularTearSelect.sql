IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyCapsularTearSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyCapsularTearSelect'
		DROP Procedure TcssListKidneyCapsularTearSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyCapsularTearSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyCapsularTearSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyCapsularTearSelect
**	Desc: Update Data in table TcssListKidneyCapsularTear
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkct.TcssListKidneyCapsularTearId AS ListId,
	tlkct.FieldValue AS FieldValue
FROM dbo.TcssListKidneyCapsularTear tlkct with (nolock)
WHERE
	(@ListId IS NULL OR tlkct.TcssListKidneyCapsularTearId = @ListId)
	AND (@FieldValue IS NULL OR tlkct.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkct.UnosValue = @UnosValue)
ORDER BY tlkct.SortOrder, tlkct.FieldValue
GO

GRANT EXEC ON TcssListKidneyCapsularTearSelect TO PUBLIC
GO
