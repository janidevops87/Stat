IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListSteroidSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListSteroidSelect'
		DROP Procedure TcssListSteroidSelect
	END
GO

PRINT 'Creating Procedure TcssListSteroidSelect'
GO

CREATE PROCEDURE dbo.TcssListSteroidSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListSteroidSelect
**	Desc: Update Data in table TcssListSteroid
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tls.TcssListSteroidId AS ListId,
	tls.FieldValue AS FieldValue
FROM dbo.TcssListSteroid tls with (nolock)
WHERE
	(@ListId IS NULL OR tls.TcssListSteroidId = @ListId)
	AND (@FieldValue IS NULL OR tls.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tls.UnosValue = @UnosValue)
ORDER BY tls.SortOrder, tls.FieldValue
GO

GRANT EXEC ON TcssListSteroidSelect TO PUBLIC
GO
