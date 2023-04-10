IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDonorMeetsDcdCriteriaSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDonorMeetsDcdCriteriaSelect'
		DROP Procedure TcssListDonorMeetsDcdCriteriaSelect
	END
GO

PRINT 'Creating Procedure TcssListDonorMeetsDcdCriteriaSelect'
GO

CREATE PROCEDURE dbo.TcssListDonorMeetsDcdCriteriaSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDonorMeetsDcdCriteriaSelect
**	Desc: Update Data in table TcssListDonorMeetsDcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldmdc.TcssListDonorMeetsDcdCriteriaId AS ListId,
	tldmdc.FieldValue AS FieldValue
FROM dbo.TcssListDonorMeetsDcdCriteria tldmdc with (nolock)
WHERE
	(@ListId IS NULL OR tldmdc.TcssListDonorMeetsDcdCriteriaId = @ListId)
	AND (@FieldValue IS NULL OR tldmdc.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tldmdc.UnosValue = @UnosValue)
ORDER BY tldmdc.SortOrder, tldmdc.FieldValue
GO

GRANT EXEC ON TcssListDonorMeetsDcdCriteriaSelect TO PUBLIC
GO
