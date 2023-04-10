IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyBiopsyUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyBiopsyUpdate'
		DROP Procedure TcssDonorDiagnosisKidneyBiopsyUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyBiopsyUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyBiopsyUpdate
(
	@TcssDonorDiagnosisKidneyBiopsyId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListKidneyId int = null,
	@DateTime datetime = null,
	@Flow varchar(50) = null,
	@PressureSystolic varchar(50) = null,
	@PressureDiastolic varchar(50) = null,
	@Resistance varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyBiopsyUpdate
**	Desc: Update Data in table TcssDonorDiagnosisKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/28/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisKidneyBiopsy
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListKidneyId = @TcssListKidneyId,
	DateTime = @DateTime,
	Flow = @Flow,
	PressureSystolic = @PressureSystolic,
	PressureDiastolic = @PressureDiastolic,
	Resistance = @Resistance
WHERE
	TcssDonorDiagnosisKidneyBiopsyId = @TcssDonorDiagnosisKidneyBiopsyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyBiopsyUpdate TO PUBLIC
GO
