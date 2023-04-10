IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListDonorMeetCdcGuidelinesSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListDonorMeetCdcGuidelinesSelect'
		DROP Procedure TcssListDonorMeetCdcGuidelinesSelect
	END
GO

PRINT 'Creating Procedure TcssListDonorMeetCdcGuidelinesSelect'
GO

CREATE PROCEDURE dbo.TcssListDonorMeetCdcGuidelinesSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListDonorMeetCdcGuidelinesSelect
**	Desc: Update Data in table TcssListDonorMeetCdcGuidelines
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tldmcg.TcssListDonorMeetCdcGuidelinesId AS ListId,
	tldmcg.FieldValue AS FieldValue
FROM dbo.TcssListDonorMeetCdcGuidelines tldmcg with (nolock)
WHERE
	(@ListId IS NULL OR tldmcg.TcssListDonorMeetCdcGuidelinesId = @ListId)
	AND (@FieldValue IS NULL OR tldmcg.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tldmcg.UnosValue = @UnosValue)
ORDER BY tldmcg.SortOrder, tldmcg.FieldValue
GO

GRANT EXEC ON TcssListDonorMeetCdcGuidelinesSelect TO PUBLIC
GO
