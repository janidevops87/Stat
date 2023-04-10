IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedicationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedicationSelect'
		DROP Procedure TcssDonorMedicationSelect
	END
GO

PRINT 'Creating Procedure TcssDonorMedicationSelect'
GO

CREATE PROCEDURE dbo.TcssDonorMedicationSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorMedicationSelect
**	Desc: Update Data in table TcssDonorMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdm.TcssDonorMedicationId,
	tdm.LastUpdateStatEmployeeId,
	tdm.LastUpdateDate,
	tdm.TcssDonorId,
	tdm.TcssListMedicationId,
	TcssListMedication.FieldValue AS TcssListMedicationName,
	tdm.StartDate,
	tdm.StopDateTime,
	tdm.Dose,
	tdm.TcssListMedicationDoseUnitId,
	tdm.Duration
FROM dbo.TcssDonorMedication tdm
	LEFT JOIN dbo.TcssListMedication ON tdm.TcssListMedicationId = TcssListMedication.TcssListMedicationId
WHERE
	tdm.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorMedicationSelect TO PUBLIC
GO
