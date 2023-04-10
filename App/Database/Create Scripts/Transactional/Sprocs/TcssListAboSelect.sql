IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListAboSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListAboSelect'
		DROP Procedure TcssListAboSelect
	END
GO

PRINT 'Creating Procedure TcssListAboSelect'
GO

CREATE PROCEDURE dbo.TcssListAboSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListAboSelect
**	Desc: Update Data in table TcssListAbo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tla.TcssListAboId AS ListId,
	tla.FieldValue AS FieldValue
FROM dbo.TcssListAbo tla with (nolock)
WHERE
	(@ListId IS NULL OR tla.TcssListAboId = @ListId)
	AND (@FieldValue IS NULL OR tla.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tla.UnosValue = @UnosValue)
ORDER BY tla.SortOrder, tla.FieldValue
GO

GRANT EXEC ON TcssListAboSelect TO PUBLIC
GO
