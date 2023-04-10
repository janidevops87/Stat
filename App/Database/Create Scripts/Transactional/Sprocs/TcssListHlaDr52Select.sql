IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaDr52Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaDr52Select'
		DROP Procedure TcssListHlaDr52Select
	END
GO

PRINT 'Creating Procedure TcssListHlaDr52Select'
GO

CREATE PROCEDURE dbo.TcssListHlaDr52Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaDr52Select
**	Desc: Update Data in table TcssListHlaDr52
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhd.TcssListHlaDr52Id AS ListId,
	tlhd.FieldValue AS FieldValue
FROM dbo.TcssListHlaDr52 tlhd with (nolock)
WHERE
	(@ListId IS NULL OR tlhd.TcssListHlaDr52Id = @ListId)
	AND (@FieldValue IS NULL OR tlhd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhd.UnosValue = @UnosValue)
ORDER BY tlhd.SortOrder, tlhd.FieldValue
GO

GRANT EXEC ON TcssListHlaDr52Select TO PUBLIC
GO
