IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListKidneyFullVenaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListKidneyFullVenaSelect'
		DROP Procedure TcssListKidneyFullVenaSelect
	END
GO

PRINT 'Creating Procedure TcssListKidneyFullVenaSelect'
GO

CREATE PROCEDURE dbo.TcssListKidneyFullVenaSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListKidneyFullVenaSelect
**	Desc: Update Data in table TcssListKidneyFullVena
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlkfv.TcssListKidneyFullVenaId AS ListId,
	tlkfv.FieldValue AS FieldValue
FROM dbo.TcssListKidneyFullVena tlkfv with (nolock)
WHERE
	(@ListId IS NULL OR tlkfv.TcssListKidneyFullVenaId = @ListId)
	AND (@FieldValue IS NULL OR tlkfv.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlkfv.UnosValue = @UnosValue)
ORDER BY tlkfv.SortOrder, tlkfv.FieldValue
GO

GRANT EXEC ON TcssListKidneyFullVenaSelect TO PUBLIC
GO
