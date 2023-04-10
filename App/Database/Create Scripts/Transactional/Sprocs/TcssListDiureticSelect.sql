IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDiureticSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDiureticSelect'
		DROP Procedure TcssListDiureticSelect
	END
GO

PRINT 'Creating Procedure TcssListDiureticSelect'
GO

CREATE PROCEDURE dbo.TcssListDiureticSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDiureticSelect
**	Desc: Update Data in table TcssListDiuretic
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tld.TcssListDiureticId AS ListId,
	tld.FieldValue AS FieldValue
FROM dbo.TcssListDiuretic tld with (nolock)
WHERE
	(@ListId IS NULL OR tld.TcssListDiureticId = @ListId)
	AND (@FieldValue IS NULL OR tld.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tld.UnosValue = @UnosValue)
ORDER BY tld.SortOrder, tld.FieldValue
GO

GRANT EXEC ON TcssListDiureticSelect TO PUBLIC
GO
