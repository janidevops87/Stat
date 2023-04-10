IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssListMedicationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssListMedicationSelect'
		DROP Procedure TcssListMedicationSelect
	END
GO

PRINT 'Creating Procedure TcssListMedicationSelect'
GO

CREATE PROCEDURE dbo.TcssListMedicationSelect
(
	@ListId int = NULL,
	@FieldValue varchar(100) = NULL,
	@UnosValue varchar(100) = NULL
)
AS

/***************************************************************************************************
**	Name: TcssListMedicationSelect
**	Desc: Update Data in table TcssListMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tlm.TcssListMedicationId AS ListId,
	tlm.FieldValue AS FieldValue
FROM dbo.TcssListMedication tlm with (nolock)
WHERE
	(@ListId IS NULL OR tlm.TcssListMedicationId = @ListId)
	AND (@FieldValue IS NULL OR tlm.FieldValue = @FieldValue)
	AND (@UnosValue IS NULL OR tlm.UnosValue = @UnosValue)
ORDER BY tlm.SortOrder, tlm.FieldValue
GO

GRANT EXEC ON TcssListMedicationSelect TO PUBLIC
GO
