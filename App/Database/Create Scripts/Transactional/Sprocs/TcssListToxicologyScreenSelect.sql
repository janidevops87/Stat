IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListToxicologyScreenSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListToxicologyScreenSelect'
		DROP Procedure TcssListToxicologyScreenSelect
	END
GO

PRINT 'Creating Procedure TcssListToxicologyScreenSelect'
GO

CREATE PROCEDURE dbo.TcssListToxicologyScreenSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListToxicologyScreenSelect
**	Desc: Update Data in table TcssListToxicologyScreen
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlts.TcssListToxicologyScreenId AS ListId,
	tlts.FieldValue AS FieldValue
FROM dbo.TcssListToxicologyScreen tlts with (nolock)
WHERE
	(@ListId IS NULL OR tlts.TcssListToxicologyScreenId = @ListId)
	AND (@FieldValue IS NULL OR tlts.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlts.UnosValue = @UnosValue)
ORDER BY tlts.SortOrder, tlts.FieldValue
GO

GRANT EXEC ON TcssListToxicologyScreenSelect TO PUBLIC
GO
