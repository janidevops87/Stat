IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaC2Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaC2Select'
		DROP Procedure TcssListHlaC2Select
	END
GO

PRINT 'Creating Procedure TcssListHlaC2Select'
GO

CREATE PROCEDURE dbo.TcssListHlaC2Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaC2Select
**	Desc: Update Data in table TcssListHlaC2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhc.TcssListHlaC2Id AS ListId,
	tlhc.FieldValue AS FieldValue
FROM dbo.TcssListHlaC2 tlhc with (nolock)
WHERE
	(@ListId IS NULL OR tlhc.TcssListHlaC2Id = @ListId)
	AND (@FieldValue IS NULL OR tlhc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhc.UnosValue = @UnosValue)
ORDER BY tlhc.SortOrder, tlhc.FieldValue
GO

GRANT EXEC ON TcssListHlaC2Select TO PUBLIC
GO
