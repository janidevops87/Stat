IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListAgeUnitSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListAgeUnitSelect'
		DROP Procedure TcssListAgeUnitSelect
	END
GO

PRINT 'Creating Procedure TcssListAgeUnitSelect'
GO

CREATE PROCEDURE dbo.TcssListAgeUnitSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListAgeUnitSelect
**	Desc: Update Data in table TcssListAgeUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlau.TcssListAgeUnitId AS ListId,
	tlau.FieldValue AS FieldValue
FROM dbo.TcssListAgeUnit tlau with (nolock)
WHERE
	(@ListId IS NULL OR tlau.TcssListAgeUnitId = @ListId)
	AND (@FieldValue IS NULL OR tlau.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlau.UnosValue = @UnosValue)
ORDER BY tlau.SortOrder, tlau.FieldValue
GO

GRANT EXEC ON TcssListAgeUnitSelect TO PUBLIC
GO
