IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyVeinSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyVeinSelect'
		DROP Procedure TcssListKidneyVeinSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyVeinSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyVeinSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyVeinSelect
**	Desc: Update Data in table TcssListKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkv.TcssListKidneyVeinId AS ListId,
	tlkv.FieldValue AS FieldValue
FROM dbo.TcssListKidneyVein tlkv with (nolock)
WHERE
	(@ListId IS NULL OR tlkv.TcssListKidneyVeinId = @ListId)
	AND (@FieldValue IS NULL OR tlkv.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkv.UnosValue = @UnosValue)
ORDER BY tlkv.SortOrder, tlkv.FieldValue
GO

GRANT EXEC ON TcssListKidneyVeinSelect TO PUBLIC
GO
