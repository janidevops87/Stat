IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCprAdministeredSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCprAdministeredSelect'
		DROP Procedure TcssListCprAdministeredSelect
	END
GO

PRINT 'Creating Procedure TcssListCprAdministeredSelect'
GO

CREATE PROCEDURE dbo.TcssListCprAdministeredSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCprAdministeredSelect
**	Desc: Update Data in table TcssListCprAdministered
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlca.TcssListCprAdministeredId AS ListId,
	tlca.FieldValue AS FieldValue
FROM dbo.TcssListCprAdministered tlca with (nolock)
WHERE
	(@ListId IS NULL OR tlca.TcssListCprAdministeredId = @ListId)
	AND (@FieldValue IS NULL OR tlca.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlca.UnosValue = @UnosValue)
ORDER BY tlca.SortOrder, tlca.FieldValue
GO

GRANT EXEC ON TcssListCprAdministeredSelect TO PUBLIC
GO
