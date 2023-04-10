IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaB1Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaB1Select'
		DROP Procedure TcssListHlaB1Select
	END
GO

PRINT 'Creating Procedure TcssListHlaB1Select'
GO

CREATE PROCEDURE dbo.TcssListHlaB1Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaB1Select
**	Desc: Update Data in table TcssListHlaB1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhb.TcssListHlaB1Id AS ListId,
	tlhb.FieldValue AS FieldValue
FROM dbo.TcssListHlaB1 tlhb with (nolock)
WHERE
	(@ListId IS NULL OR tlhb.TcssListHlaB1Id = @ListId)
	AND (@FieldValue IS NULL OR tlhb.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhb.UnosValue = @UnosValue)
ORDER BY tlhb.SortOrder, tlhb.FieldValue
GO

GRANT EXEC ON TcssListHlaB1Select TO PUBLIC
GO
