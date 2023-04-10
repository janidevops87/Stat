IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedicationUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedicationUpdate'
		DROP Procedure TcssDonorMedicationUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorMedicationUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorMedicationUpdate
(
	@TcssDonorMedicationId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListMedicationId int = null,
	@TcssListMedicationName varchar(100) = null,
	@StartDate smalldatetime = null,
	@StopDateTime smalldatetime = null,
	@Dose decimal(18,2) = null,
	@TcssListMedicationDoseUnitId int = null,
	@Duration int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorMedicationUpdate
**	Desc: Update Data in table TcssDonorMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorMedication
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListMedicationId = @TcssListMedicationId,
	StartDate = @StartDate,
	StopDateTime = @StopDateTime,
	Dose = @Dose,
	TcssListMedicationDoseUnitId = @TcssListMedicationDoseUnitId,
	Duration = @Duration
WHERE
	TcssDonorMedicationId = @TcssDonorMedicationId
GO

GRANT EXEC ON TcssDonorMedicationUpdate TO PUBLIC
GO
