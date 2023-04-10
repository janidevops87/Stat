IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaC1Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaC1Select'
		DROP Procedure TcssListHlaC1Select
	END
GO

PRINT 'Creating Procedure TcssListHlaC1Select'
GO

CREATE PROCEDURE dbo.TcssListHlaC1Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaC1Select
**	Desc: Update Data in table TcssListHlaC1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhc.TcssListHlaC1Id AS ListId,
	tlhc.FieldValue AS FieldValue
FROM dbo.TcssListHlaC1 tlhc with (nolock)
WHERE
	(@ListId IS NULL OR tlhc.TcssListHlaC1Id = @ListId)
	AND (@FieldValue IS NULL OR tlhc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhc.UnosValue = @UnosValue)
ORDER BY tlhc.SortOrder, tlhc.FieldValue
GO

GRANT EXEC ON TcssListHlaC1Select TO PUBLIC
GO
