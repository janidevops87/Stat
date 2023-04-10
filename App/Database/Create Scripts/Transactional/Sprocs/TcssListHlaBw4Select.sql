IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaBw4Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaBw4Select'
		DROP Procedure TcssListHlaBw4Select
	END
GO

PRINT 'Creating Procedure TcssListHlaBw4Select'
GO

CREATE PROCEDURE dbo.TcssListHlaBw4Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaBw4Select
**	Desc: Update Data in table TcssListHlaBw4
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhb.TcssListHlaBw4Id AS ListId,
	tlhb.FieldValue AS FieldValue
FROM dbo.TcssListHlaBw4 tlhb with (nolock)
WHERE
	(@ListId IS NULL OR tlhb.TcssListHlaBw4Id = @ListId)
	AND (@FieldValue IS NULL OR tlhb.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhb.UnosValue = @UnosValue)
ORDER BY tlhb.SortOrder, tlhb.FieldValue
GO

GRANT EXEC ON TcssListHlaBw4Select TO PUBLIC
GO
