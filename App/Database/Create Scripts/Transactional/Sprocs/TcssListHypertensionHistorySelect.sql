IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHypertensionHistorySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHypertensionHistorySelect'
		DROP Procedure TcssListHypertensionHistorySelect
	END
GO

PRINT 'Creating Procedure TcssListHypertensionHistorySelect'
GO

CREATE PROCEDURE dbo.TcssListHypertensionHistorySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHypertensionHistorySelect
**	Desc: Update Data in table TcssListHypertensionHistory
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhh.TcssListHypertensionHistoryId AS ListId,
	tlhh.FieldValue AS FieldValue
FROM dbo.TcssListHypertensionHistory tlhh with (nolock)
WHERE
	(@ListId IS NULL OR tlhh.TcssListHypertensionHistoryId = @ListId)
	AND (@FieldValue IS NULL OR tlhh.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhh.UnosValue = @UnosValue)
ORDER BY tlhh.SortOrder, tlhh.FieldValue
GO

GRANT EXEC ON TcssListHypertensionHistorySelect TO PUBLIC
GO
