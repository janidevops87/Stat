IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDiagnosisHeartMethodSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDiagnosisHeartMethodSelect'
		DROP Procedure TcssListDiagnosisHeartMethodSelect
	END
GO

PRINT 'Creating Procedure TcssListDiagnosisHeartMethodSelect'
GO

CREATE PROCEDURE dbo.TcssListDiagnosisHeartMethodSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDiagnosisHeartMethodSelect
**	Desc: Update Data in table TcssListDiagnosisHeartMethod
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldhm.TcssListDiagnosisHeartMethodId AS ListId,
	tldhm.FieldValue AS FieldValue
FROM dbo.TcssListDiagnosisHeartMethod tldhm with (nolock)
WHERE
	(@ListId IS NULL OR tldhm.TcssListDiagnosisHeartMethodId = @ListId)
	AND (@FieldValue IS NULL OR tldhm.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tldhm.UnosValue = @UnosValue)
ORDER BY tldhm.SortOrder, tldhm.FieldValue
GO

GRANT EXEC ON TcssListDiagnosisHeartMethodSelect TO PUBLIC
GO
