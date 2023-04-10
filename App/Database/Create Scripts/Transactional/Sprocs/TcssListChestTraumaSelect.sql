IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListChestTraumaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListChestTraumaSelect'
		DROP Procedure TcssListChestTraumaSelect
	END
GO

PRINT 'Creating Procedure TcssListChestTraumaSelect'
GO

CREATE PROCEDURE dbo.TcssListChestTraumaSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListChestTraumaSelect
**	Desc: Update Data in table TcssListChestTrauma
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlct.TcssListChestTraumaId AS ListId,
	tlct.FieldValue AS FieldValue
FROM dbo.TcssListChestTrauma tlct with (nolock)
WHERE
	(@ListId IS NULL OR tlct.TcssListChestTraumaId = @ListId)
	AND (@FieldValue IS NULL OR tlct.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlct.UnosValue = @UnosValue)
ORDER BY tlct.SortOrder, tlct.FieldValue
GO

GRANT EXEC ON TcssListChestTraumaSelect TO PUBLIC
GO
