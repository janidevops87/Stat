IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHeavyAlcoholUseSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHeavyAlcoholUseSelect'
		DROP Procedure TcssListHeavyAlcoholUseSelect
	END
GO

PRINT 'Creating Procedure TcssListHeavyAlcoholUseSelect'
GO

CREATE PROCEDURE dbo.TcssListHeavyAlcoholUseSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHeavyAlcoholUseSelect
**	Desc: Update Data in table TcssListHeavyAlcoholUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhau.TcssListHeavyAlcoholUseId AS ListId,
	tlhau.FieldValue AS FieldValue
FROM dbo.TcssListHeavyAlcoholUse tlhau with (nolock)
WHERE
	(@ListId IS NULL OR tlhau.TcssListHeavyAlcoholUseId = @ListId)
	AND (@FieldValue IS NULL OR tlhau.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhau.UnosValue = @UnosValue)
ORDER BY tlhau.SortOrder, tlhau.FieldValue
GO

GRANT EXEC ON TcssListHeavyAlcoholUseSelect TO PUBLIC
GO
