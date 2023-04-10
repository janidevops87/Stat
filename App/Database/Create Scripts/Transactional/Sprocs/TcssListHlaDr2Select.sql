IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaDr2Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaDr2Select'
		DROP Procedure TcssListHlaDr2Select
	END
GO

PRINT 'Creating Procedure TcssListHlaDr2Select'
GO

CREATE PROCEDURE dbo.TcssListHlaDr2Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaDr2Select
**	Desc: Update Data in table TcssListHlaDr2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhd.TcssListHlaDr2Id AS ListId,
	tlhd.FieldValue AS FieldValue
FROM dbo.TcssListHlaDr2 tlhd with (nolock)
WHERE
	(@ListId IS NULL OR tlhd.TcssListHlaDr2Id = @ListId)
	AND (@FieldValue IS NULL OR tlhd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhd.UnosValue = @UnosValue)
ORDER BY tlhd.SortOrder, tlhd.FieldValue
GO

GRANT EXEC ON TcssListHlaDr2Select TO PUBLIC
GO
