IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHlaDr53Select')
	BEGIN
		PRINT 'Dropping Procedure TcssListHlaDr53Select'
		DROP Procedure TcssListHlaDr53Select
	END
GO

PRINT 'Creating Procedure TcssListHlaDr53Select'
GO

CREATE PROCEDURE dbo.TcssListHlaDr53Select
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHlaDr53Select
**	Desc: Update Data in table TcssListHlaDr53
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhd.TcssListHlaDr53Id AS ListId,
	tlhd.FieldValue AS FieldValue
FROM dbo.TcssListHlaDr53 tlhd with (nolock)
WHERE
	(@ListId IS NULL OR tlhd.TcssListHlaDr53Id = @ListId)
	AND (@FieldValue IS NULL OR tlhd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhd.UnosValue = @UnosValue)
ORDER BY tlhd.SortOrder, tlhd.FieldValue
GO

GRANT EXEC ON TcssListHlaDr53Select TO PUBLIC
GO
