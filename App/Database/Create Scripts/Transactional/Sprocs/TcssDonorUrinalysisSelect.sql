IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorUrinalysisSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorUrinalysisSelect'
		DROP Procedure TcssDonorUrinalysisSelect
	END
GO

PRINT 'Creating Procedure TcssDonorUrinalysisSelect'
GO

CREATE PROCEDURE dbo.TcssDonorUrinalysisSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorUrinalysisSelect
**	Desc: Update Data in table TcssDonorUrinalysis
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tdu.TcssDonorUrinalysisId,
	tdu.LastUpdateStatEmployeeId,
	tdu.LastUpdateDate,
	tdu.TcssDonorId,
	tdu.SampleDateTime,
	tdu.Color,
	tdu.AppearanceId,
	tdu.Ph,
	tdu.SpecificGravity,
	tdu.TcssListUrinalysisProteinId,
	tdu.TcssListUrinalysisGlucoseId,
	tdu.TcssListUrinalysisBloodId,
	tdu.TcssListUrinalysisRbcId,
	tdu.TcssListUrinalysisWbcId,
	tdu.TcssListUrinalysisEpithId,
	tdu.TcssListUrinalysisCastId,
	tdu.TcssListUrinalysisBacteriaId,
	tdu.TcssListUrinalysisLeukocyteId,
	tdu.TcssUrinalysisProtein,
	tdu.TcssUrinalysisGlucose,
	tdu.TcssUrinalysisBlood,
	tdu.TcssUrinalysisRbc,
	tdu.TcssUrinalysisWbc,
	tdu.TcssUrinalysisEpith,
	tdu.TcssUrinalysisCast,
	tdu.TcssUrinalysisBacteria,
	tdu.TcssUrinalysisLeukocyte
FROM dbo.TcssDonorUrinalysis tdu
WHERE
	tdu.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorUrinalysisSelect TO PUBLIC
GO
