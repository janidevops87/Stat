IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHistoryOfDiabetesSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHistoryOfDiabetesSelect'
		DROP Procedure TcssListHistoryOfDiabetesSelect
	END
GO

PRINT 'Creating Procedure TcssListHistoryOfDiabetesSelect'
GO

CREATE PROCEDURE dbo.TcssListHistoryOfDiabetesSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHistoryOfDiabetesSelect
**	Desc: Update Data in table TcssListHistoryOfDiabetes
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhod.TcssListHistoryOfDiabetesId AS ListId,
	tlhod.FieldValue AS FieldValue
FROM dbo.TcssListHistoryOfDiabetes tlhod with (nolock)
WHERE
	(@ListId IS NULL OR tlhod.TcssListHistoryOfDiabetesId = @ListId)
	AND (@FieldValue IS NULL OR tlhod.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhod.UnosValue = @UnosValue)
ORDER BY tlhod.SortOrder, tlhod.FieldValue
GO

GRANT EXEC ON TcssListHistoryOfDiabetesSelect TO PUBLIC
GO
