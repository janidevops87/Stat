IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaDr1Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaDr1Select'
		DROP Procedure TcssListHlaDr1Select
	END
GO

PRINT 'Creating Procedure TcssListHlaDr1Select'
GO

CREATE PROCEDURE dbo.TcssListHlaDr1Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaDr1Select
**	Desc: Update Data in table TcssListHlaDr1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhd.TcssListHlaDr1Id AS ListId,
	tlhd.FieldValue AS FieldValue
FROM dbo.TcssListHlaDr1 tlhd with (nolock)
WHERE
	(@ListId IS NULL OR tlhd.TcssListHlaDr1Id = @ListId)
	AND (@FieldValue IS NULL OR tlhd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhd.UnosValue = @UnosValue)
ORDER BY tlhd.SortOrder, tlhd.FieldValue
GO

GRANT EXEC ON TcssListHlaDr1Select TO PUBLIC
GO
