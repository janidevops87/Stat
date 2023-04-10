IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneySelect'
		DROP Procedure TcssListKidneySelect
	END
GO

PRINT 'Creating Procedure TcssListKidneySelect'
GO

CREATE PROCEDURE dbo.TcssListKidneySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneySelect
**	Desc: Update Data in table TcssListKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlk.TcssListKidneyId AS ListId,
	tlk.FieldValue AS FieldValue
FROM dbo.TcssListKidney tlk with (nolock)
WHERE
	(@ListId IS NULL OR tlk.TcssListKidneyId = @ListId)
	AND (@FieldValue IS NULL OR tlk.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlk.UnosValue = @UnosValue)
ORDER BY tlk.SortOrder, tlk.FieldValue
GO

GRANT EXEC ON TcssListKidneySelect TO PUBLIC
GO
