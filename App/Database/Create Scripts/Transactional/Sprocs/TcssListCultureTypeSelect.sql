IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCultureTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCultureTypeSelect'
		DROP Procedure TcssListCultureTypeSelect
	END
GO

PRINT 'Creating Procedure TcssListCultureTypeSelect'
GO

CREATE PROCEDURE dbo.TcssListCultureTypeSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCultureTypeSelect
**	Desc: Update Data in table TcssListCultureType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlct.TcssListCultureTypeId AS ListId,
	tlct.FieldValue AS FieldValue
FROM dbo.TcssListCultureType tlct with (nolock)
WHERE
	(@ListId IS NULL OR tlct.TcssListCultureTypeId = @ListId)
	AND (@FieldValue IS NULL OR tlct.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlct.UnosValue = @UnosValue)
ORDER BY tlct.SortOrder, tlct.FieldValue
GO

GRANT EXEC ON TcssListCultureTypeSelect TO PUBLIC
GO
