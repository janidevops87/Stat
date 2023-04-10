IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaDq1Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaDq1Select'
		DROP Procedure TcssListHlaDq1Select
	END
GO

PRINT 'Creating Procedure TcssListHlaDq1Select'
GO

CREATE PROCEDURE dbo.TcssListHlaDq1Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaDq1Select
**	Desc: Update Data in table TcssListHlaDq1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhd.TcssListHlaDq1Id AS ListId,
	tlhd.FieldValue AS FieldValue
FROM dbo.TcssListHlaDq1 tlhd with (nolock)
WHERE
	(@ListId IS NULL OR tlhd.TcssListHlaDq1Id = @ListId)
	AND (@FieldValue IS NULL OR tlhd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhd.UnosValue = @UnosValue)
ORDER BY tlhd.SortOrder, tlhd.FieldValue
GO

GRANT EXEC ON TcssListHlaDq1Select TO PUBLIC
GO
