IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaDq2Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaDq2Select'
		DROP Procedure TcssListHlaDq2Select
	END
GO

PRINT 'Creating Procedure TcssListHlaDq2Select'
GO

CREATE PROCEDURE dbo.TcssListHlaDq2Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaDq2Select
**	Desc: Update Data in table TcssListHlaDq2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhd.TcssListHlaDq2Id AS ListId,
	tlhd.FieldValue AS FieldValue
FROM dbo.TcssListHlaDq2 tlhd with (nolock)
WHERE
	(@ListId IS NULL OR tlhd.TcssListHlaDq2Id = @ListId)
	AND (@FieldValue IS NULL OR tlhd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhd.UnosValue = @UnosValue)
ORDER BY tlhd.SortOrder, tlhd.FieldValue
GO

GRANT EXEC ON TcssListHlaDq2Select TO PUBLIC
GO
