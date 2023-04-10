IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaB2Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaB2Select'
		DROP Procedure TcssListHlaB2Select
	END
GO

PRINT 'Creating Procedure TcssListHlaB2Select'
GO

CREATE PROCEDURE dbo.TcssListHlaB2Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaB2Select
**	Desc: Update Data in table TcssListHlaB2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhb.TcssListHlaB2Id AS ListId,
	tlhb.FieldValue AS FieldValue
FROM dbo.TcssListHlaB2 tlhb with (nolock)
WHERE
	(@ListId IS NULL OR tlhb.TcssListHlaB2Id = @ListId)
	AND (@FieldValue IS NULL OR tlhb.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhb.UnosValue = @UnosValue)
ORDER BY tlhb.SortOrder, tlhb.FieldValue
GO

GRANT EXEC ON TcssListHlaB2Select TO PUBLIC
GO
