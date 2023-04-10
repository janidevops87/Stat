IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedicationInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedicationInsert'
		DROP Procedure TcssDonorMedicationInsert
	END
GO

PRINT 'Creating Procedure TcssDonorMedicationInsert'
GO

CREATE PROCEDURE dbo.TcssDonorMedicationInsert
(
	@TcssDonorMedicationId int output,
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
**	Name: TcssDonorMedicationInsert
**	Desc: Insert Data into table TcssDonorMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorMedication
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListMedicationId,
	StartDate,
	StopDateTime,
	Dose,
	TcssListMedicationDoseUnitId,
	Duration
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListMedicationId,
	@StartDate,
	@StopDateTime,
	@Dose,
	@TcssListMedicationDoseUnitId,
	@Duration
)

-- Return the new identity value
SET @TcssDonorMedicationId = @@Identity

GO

GRANT EXEC ON TcssDonorMedicationInsert TO PUBLIC
GO
