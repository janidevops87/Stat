IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListT3Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListT3Select'
		DROP Procedure TcssListT3Select
	END
GO

PRINT 'Creating Procedure TcssListT3Select'
GO

CREATE PROCEDURE dbo.TcssListT3Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListT3Select
**	Desc: Update Data in table TcssListT3
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlt.TcssListT3Id AS ListId,
	tlt.FieldValue AS FieldValue
FROM dbo.TcssListT3 tlt with (nolock)
WHERE
	(@ListId IS NULL OR tlt.TcssListT3Id = @ListId)
	AND (@FieldValue IS NULL OR tlt.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlt.UnosValue = @UnosValue)
ORDER BY tlt.SortOrder, tlt.FieldValue
GO

GRANT EXEC ON TcssListT3Select TO PUBLIC
GO
