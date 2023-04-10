IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyAorticCuffSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyAorticCuffSelect'
		DROP Procedure TcssListKidneyAorticCuffSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyAorticCuffSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyAorticCuffSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyAorticCuffSelect
**	Desc: Update Data in table TcssListKidneyAorticCuff
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkac.TcssListKidneyAorticCuffId AS ListId,
	tlkac.FieldValue AS FieldValue
FROM dbo.TcssListKidneyAorticCuff tlkac with (nolock)
WHERE
	(@ListId IS NULL OR tlkac.TcssListKidneyAorticCuffId = @ListId)
	AND (@FieldValue IS NULL OR tlkac.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkac.UnosValue = @UnosValue)
ORDER BY tlkac.SortOrder, tlkac.FieldValue
GO

GRANT EXEC ON TcssListKidneyAorticCuffSelect TO PUBLIC
GO
