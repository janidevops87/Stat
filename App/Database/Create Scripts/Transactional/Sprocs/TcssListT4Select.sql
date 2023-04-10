IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListT4Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListT4Select'
		DROP Procedure TcssListT4Select
	END
GO

PRINT 'Creating Procedure TcssListT4Select'
GO

CREATE PROCEDURE dbo.TcssListT4Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListT4Select
**	Desc: Update Data in table TcssListT4
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlt.TcssListT4Id AS ListId,
	tlt.FieldValue AS FieldValue
FROM dbo.TcssListT4 tlt with (nolock)
WHERE
	(@ListId IS NULL OR tlt.TcssListT4Id = @ListId)
	AND (@FieldValue IS NULL OR tlt.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlt.UnosValue = @UnosValue)
ORDER BY tlt.SortOrder, tlt.FieldValue
GO

GRANT EXEC ON TcssListT4Select TO PUBLIC
GO
