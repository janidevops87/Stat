IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListTestTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListTestTypeSelect'
		DROP Procedure TcssListTestTypeSelect
	END
GO

PRINT 'Creating Procedure TcssListTestTypeSelect'
GO

CREATE PROCEDURE dbo.TcssListTestTypeSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListTestTypeSelect
**	Desc: Update Data in table TcssListTestType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tltt.TcssListTestTypeId AS ListId,
	tltt.FieldValue AS FieldValue
FROM dbo.TcssListTestType tltt with (nolock)
WHERE
	(@ListId IS NULL OR tltt.TcssListTestTypeId = @ListId)
	AND (@FieldValue IS NULL OR tltt.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tltt.UnosValue = @UnosValue)
ORDER BY tltt.SortOrder, tltt.FieldValue
GO

GRANT EXEC ON TcssListTestTypeSelect TO PUBLIC
GO
