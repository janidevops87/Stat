IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListStatusOfImportDataSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListStatusOfImportDataSelect'
		DROP Procedure TcssListStatusOfImportDataSelect
	END
GO

PRINT 'Creating Procedure TcssListStatusOfImportDataSelect'
GO

CREATE PROCEDURE dbo.TcssListStatusOfImportDataSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListStatusOfImportDataSelect
**	Desc: Update Data in table TcssListStatusOfImportData
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlsoid.TcssListStatusOfImportDataId AS ListId,
	tlsoid.FieldValue AS FieldValue
FROM dbo.TcssListStatusOfImportData tlsoid with (nolock)
WHERE
	(@ListId IS NULL OR tlsoid.TcssListStatusOfImportDataId = @ListId)
	AND (@FieldValue IS NULL OR tlsoid.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlsoid.UnosValue = @UnosValue)
ORDER BY tlsoid.SortOrder, tlsoid.FieldValue
GO

GRANT EXEC ON TcssListStatusOfImportDataSelect TO PUBLIC
GO
