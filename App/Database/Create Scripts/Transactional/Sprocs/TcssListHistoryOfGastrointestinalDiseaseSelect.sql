IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListHistoryOfGastrointestinalDiseaseSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListHistoryOfGastrointestinalDiseaseSelect'
		DROP Procedure TcssListHistoryOfGastrointestinalDiseaseSelect
	END
GO

PRINT 'Creating Procedure TcssListHistoryOfGastrointestinalDiseaseSelect'
GO

CREATE PROCEDURE dbo.TcssListHistoryOfGastrointestinalDiseaseSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListHistoryOfGastrointestinalDiseaseSelect
**	Desc: Update Data in table TcssListHistoryOfGastrointestinalDisease
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlhogd.TcssListHistoryOfGastrointestinalDiseaseId AS ListId,
	tlhogd.FieldValue AS FieldValue
FROM dbo.TcssListHistoryOfGastrointestinalDisease tlhogd with (nolock)
WHERE
	(@ListId IS NULL OR tlhogd.TcssListHistoryOfGastrointestinalDiseaseId = @ListId)
	AND (@FieldValue IS NULL OR tlhogd.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlhogd.UnosValue = @UnosValue)
ORDER BY tlhogd.SortOrder, tlhogd.FieldValue
GO

GRANT EXEC ON TcssListHistoryOfGastrointestinalDiseaseSelect TO PUBLIC
GO
