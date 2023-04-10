IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListStatusSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListStatusSelect'
		DROP Procedure TcssListStatusSelect
	END
GO

PRINT 'Creating Procedure TcssListStatusSelect'
GO

CREATE PROCEDURE dbo.TcssListStatusSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListStatusSelect
**	Desc: Update Data in table TcssListStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tls.TcssListStatusId AS ListId,
	tls.FieldValue AS FieldValue
FROM dbo.TcssListStatus tls with (nolock)
WHERE
	(@ListId IS NULL OR tls.TcssListStatusId = @ListId)
	AND (@FieldValue IS NULL OR tls.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tls.UnosValue = @UnosValue)
ORDER BY tls.SortOrder, tls.FieldValue
GO

GRANT EXEC ON TcssListStatusSelect TO PUBLIC
GO
