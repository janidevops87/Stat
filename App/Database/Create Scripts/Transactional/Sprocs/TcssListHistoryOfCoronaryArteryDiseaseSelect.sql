IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHistoryOfCoronaryArteryDiseaseSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHistoryOfCoronaryArteryDiseaseSelect'
		DROP Procedure TcssListHistoryOfCoronaryArteryDiseaseSelect
	END
GO

PRINT 'Creating Procedure TcssListHistoryOfCoronaryArteryDiseaseSelect'
GO

CREATE PROCEDURE dbo.TcssListHistoryOfCoronaryArteryDiseaseSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHistoryOfCoronaryArteryDiseaseSelect
**	Desc: Update Data in table TcssListHistoryOfCoronaryArteryDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhocad.TcssListHistoryOfCoronaryArteryDiseaseId AS ListId,
	tlhocad.FieldValue AS FieldValue
FROM dbo.TcssListHistoryOfCoronaryArteryDisease tlhocad with (nolock)
WHERE
	(@ListId IS NULL OR tlhocad.TcssListHistoryOfCoronaryArteryDiseaseId = @ListId)
	AND (@FieldValue IS NULL OR tlhocad.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhocad.UnosValue = @UnosValue)
ORDER BY tlhocad.SortOrder, tlhocad.FieldValue
GO

GRANT EXEC ON TcssListHistoryOfCoronaryArteryDiseaseSelect TO PUBLIC
GO
