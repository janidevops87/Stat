IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListCompliantWithTreatmentSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListCompliantWithTreatmentSelect'
		DROP Procedure TcssListCompliantWithTreatmentSelect
	END
GO

PRINT 'Creating Procedure TcssListCompliantWithTreatmentSelect'
GO

CREATE PROCEDURE dbo.TcssListCompliantWithTreatmentSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListCompliantWithTreatmentSelect
**	Desc: Update Data in table TcssListCompliantWithTreatment
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlcwt.TcssListCompliantWithTreatmentId AS ListId,
	tlcwt.FieldValue AS FieldValue
FROM dbo.TcssListCompliantWithTreatment tlcwt with (nolock)
WHERE
	(@ListId IS NULL OR tlcwt.TcssListCompliantWithTreatmentId = @ListId)
	AND (@FieldValue IS NULL OR tlcwt.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlcwt.UnosValue = @UnosValue)
ORDER BY tlcwt.SortOrder, tlcwt.FieldValue
GO

GRANT EXEC ON TcssListCompliantWithTreatmentSelect TO PUBLIC
GO
