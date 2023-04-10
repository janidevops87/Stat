IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListArginineVasopressinSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListArginineVasopressinSelect'
		DROP Procedure TcssListArginineVasopressinSelect
	END
GO

PRINT 'Creating Procedure TcssListArginineVasopressinSelect'
GO

CREATE PROCEDURE dbo.TcssListArginineVasopressinSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListArginineVasopressinSelect
**	Desc: Update Data in table TcssListArginineVasopressin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlav.TcssListArginineVasopressinId AS ListId,
	tlav.FieldValue AS FieldValue
FROM dbo.TcssListArginineVasopressin tlav with (nolock)
WHERE
	(@ListId IS NULL OR tlav.TcssListArginineVasopressinId = @ListId)
	AND (@FieldValue IS NULL OR tlav.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlav.UnosValue = @UnosValue)
ORDER BY tlav.SortOrder, tlav.FieldValue
GO

GRANT EXEC ON TcssListArginineVasopressinSelect TO PUBLIC
GO
