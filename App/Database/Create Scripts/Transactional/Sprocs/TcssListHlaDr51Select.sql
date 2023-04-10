IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaDr51Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaDr51Select'
		DROP Procedure TcssListHlaDr51Select
	END
GO

PRINT 'Creating Procedure TcssListHlaDr51Select'
GO

CREATE PROCEDURE dbo.TcssListHlaDr51Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaDr51Select
**	Desc: Update Data in table TcssListHlaDr51
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhd.TcssListHlaDr51Id AS ListId,
	tlhd.FieldValue AS FieldValue
FROM dbo.TcssListHlaDr51 tlhd with (nolock)
WHERE
	(@ListId IS NULL OR tlhd.TcssListHlaDr51Id = @ListId)
	AND (@FieldValue IS NULL OR tlhd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhd.UnosValue = @UnosValue)
ORDER BY tlhd.SortOrder, tlhd.FieldValue
GO

GRANT EXEC ON TcssListHlaDr51Select TO PUBLIC
GO
