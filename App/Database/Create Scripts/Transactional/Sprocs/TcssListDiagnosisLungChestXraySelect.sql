IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDiagnosisLungChestXraySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDiagnosisLungChestXraySelect'
		DROP Procedure TcssListDiagnosisLungChestXraySelect
	END
GO

PRINT 'Creating Procedure TcssListDiagnosisLungChestXraySelect'
GO

CREATE PROCEDURE dbo.TcssListDiagnosisLungChestXraySelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDiagnosisLungChestXraySelect
**	Desc: Update Data in table TcssListDiagnosisLungChestXray
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldlcx.TcssListDiagnosisLungChestXrayId AS ListId,
	tldlcx.FieldValue AS FieldValue
FROM dbo.TcssListDiagnosisLungChestXray tldlcx with (nolock)
WHERE
	(@ListId IS NULL OR tldlcx.TcssListDiagnosisLungChestXrayId = @ListId)
	AND (@FieldValue IS NULL OR tldlcx.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tldlcx.UnosValue = @UnosValue)
ORDER BY tldlcx.SortOrder, tldlcx.FieldValue
GO

GRANT EXEC ON TcssListDiagnosisLungChestXraySelect TO PUBLIC
GO
