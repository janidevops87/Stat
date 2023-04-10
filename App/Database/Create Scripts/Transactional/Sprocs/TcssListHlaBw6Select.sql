IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaBw6Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaBw6Select'
		DROP Procedure TcssListHlaBw6Select
	END
GO

PRINT 'Creating Procedure TcssListHlaBw6Select'
GO

CREATE PROCEDURE dbo.TcssListHlaBw6Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaBw6Select
**	Desc: Update Data in table TcssListHlaBw6
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhb.TcssListHlaBw6Id AS ListId,
	tlhb.FieldValue AS FieldValue
FROM dbo.TcssListHlaBw6 tlhb with (nolock)
WHERE
	(@ListId IS NULL OR tlhb.TcssListHlaBw6Id = @ListId)
	AND (@FieldValue IS NULL OR tlhb.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhb.UnosValue = @UnosValue)
ORDER BY tlhb.SortOrder, tlhb.FieldValue
GO

GRANT EXEC ON TcssListHlaBw6Select TO PUBLIC
GO
