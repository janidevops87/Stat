IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyBiopsyInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyBiopsyInsert'
		DROP Procedure TcssDonorDiagnosisKidneyBiopsyInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyBiopsyInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyBiopsyInsert
(
	@TcssDonorDiagnosisKidneyBiopsyId int output,
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
**	Name: TcssDonorDiagnosisKidneyBiopsyInsert
**	Desc: Insert Data into table TcssDonorDiagnosisKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/28/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisKidneyBiopsy
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListKidneyId,
	DateTime,
	Flow,
	PressureSystolic,
	PressureDiastolic,
	Resistance
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListKidneyId,
	@DateTime,
	@Flow,
	@PressureSystolic,
	@PressureDiastolic,
	@Resistance
)

-- Return the new identity value
SET @TcssDonorDiagnosisKidneyBiopsyId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisKidneyBiopsyInsert TO PUBLIC
GO
