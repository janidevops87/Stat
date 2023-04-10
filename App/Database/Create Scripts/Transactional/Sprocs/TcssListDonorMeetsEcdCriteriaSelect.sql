IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDonorMeetsEcdCriteriaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDonorMeetsEcdCriteriaSelect'
		DROP Procedure TcssListDonorMeetsEcdCriteriaSelect
	END
GO

PRINT 'Creating Procedure TcssListDonorMeetsEcdCriteriaSelect'
GO

CREATE PROCEDURE dbo.TcssListDonorMeetsEcdCriteriaSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDonorMeetsEcdCriteriaSelect
**	Desc: Update Data in table TcssListDonorMeetsEcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldmec.TcssListDonorMeetsEcdCriteriaId AS ListId,
	tldmec.FieldValue AS FieldValue
FROM dbo.TcssListDonorMeetsEcdCriteria tldmec with (nolock)
WHERE
	(@ListId IS NULL OR tldmec.TcssListDonorMeetsEcdCriteriaId = @ListId)
	AND (@FieldValue IS NULL OR tldmec.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tldmec.UnosValue = @UnosValue)
ORDER BY tldmec.SortOrder, tldmec.FieldValue
GO

GRANT EXEC ON TcssListDonorMeetsEcdCriteriaSelect TO PUBLIC
GO
