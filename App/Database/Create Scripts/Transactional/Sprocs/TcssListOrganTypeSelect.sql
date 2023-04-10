IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListOrganTypeSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListOrganTypeSelect'
		DROP Procedure TcssListOrganTypeSelect
	END
GO

PRINT 'Creating Procedure TcssListOrganTypeSelect'
GO

CREATE PROCEDURE dbo.TcssListOrganTypeSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListOrganTypeSelect
**	Desc: Update Data in table TcssListOrganType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlot.TcssListOrganTypeId AS ListId,
	tlot.FieldValue AS FieldValue
FROM dbo.TcssListOrganType tlot with (nolock)
WHERE
	(@ListId IS NULL OR tlot.TcssListOrganTypeId = @ListId)
	AND (@FieldValue IS NULL OR tlot.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlot.UnosValue = @UnosValue)
ORDER BY tlot.SortOrder, tlot.FieldValue
GO

GRANT EXEC ON TcssListOrganTypeSelect TO PUBLIC
GO
