IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListMedicationDoseUnitSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListMedicationDoseUnitSelect'
		DROP Procedure TcssListMedicationDoseUnitSelect
	END
GO

PRINT 'Creating Procedure TcssListMedicationDoseUnitSelect'
GO

CREATE PROCEDURE dbo.TcssListMedicationDoseUnitSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListMedicationDoseUnitSelect
**	Desc: Update Data in table TcssListMedicationDoseUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlmdu.TcssListMedicationDoseUnitId AS ListId,
	tlmdu.FieldValue AS FieldValue
FROM dbo.TcssListMedicationDoseUnit tlmdu with (nolock)
WHERE
	(@ListId IS NULL OR tlmdu.TcssListMedicationDoseUnitId = @ListId)
	AND (@FieldValue IS NULL OR tlmdu.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlmdu.UnosValue = @UnosValue)
ORDER BY tlmdu.SortOrder, tlmdu.FieldValue
GO

GRANT EXEC ON TcssListMedicationDoseUnitSelect TO PUBLIC
GO
