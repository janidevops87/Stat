IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListOtherOrganSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListOtherOrganSelect'
		DROP Procedure TcssListOtherOrganSelect
	END
GO

PRINT 'Creating Procedure TcssListOtherOrganSelect'
GO

CREATE PROCEDURE dbo.TcssListOtherOrganSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListOtherOrganSelect
**	Desc: Update Data in table TcssListOtherOrgan
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tloo.TcssListOtherOrganId AS ListId,
	tloo.FieldValue AS FieldValue
FROM dbo.TcssListOtherOrgan tloo with (nolock)
WHERE
	(@ListId IS NULL OR tloo.TcssListOtherOrganId = @ListId)
	AND (@FieldValue IS NULL OR tloo.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tloo.UnosValue = @UnosValue)
ORDER BY tloo.SortOrder, tloo.FieldValue
GO

GRANT EXEC ON TcssListOtherOrganSelect TO PUBLIC
GO
