IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorUrinalysisUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorUrinalysisUpdate'
		DROP Procedure TcssDonorUrinalysisUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorUrinalysisUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorUrinalysisUpdate
(
	@TcssDonorUrinalysisId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null,
	@Color varchar(10) = null,
	@AppearanceId varchar(10) = null,
	@Ph decimal(18,2) = null,
	@SpecificGravity decimal(18,5) = null,
	@TcssListUrinalysisProteinId int = null,
	@TcssListUrinalysisGlucoseId int = null,
	@TcssListUrinalysisBloodId int = null,
	@TcssListUrinalysisRbcId int = null,
	@TcssListUrinalysisWbcId int = null,
	@TcssListUrinalysisEpithId int = null,
	@TcssListUrinalysisCastId int = null,
	@TcssListUrinalysisBacteriaId int = null,
	@TcssListUrinalysisLeukocyteId int = null,
	@TcssUrinalysisProtein varchar(50) = null,
	@TcssUrinalysisGlucose varchar(50) = null,
	@TcssUrinalysisBlood varchar(50) = null,
	@TcssUrinalysisRbc varchar(50) = null,
	@TcssUrinalysisWbc varchar(50) = null,
	@TcssUrinalysisEpith varchar(50) = null,
	@TcssUrinalysisCast varchar(50) = null,
	@TcssUrinalysisBacteria varchar(50) = null,
	@TcssUrinalysisLeukocyte varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorUrinalysisUpdate
**	Desc: Update Data in table TcssDonorUrinalysis
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorUrinalysis
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	SampleDateTime = @SampleDateTime,
	Color = @Color,
	AppearanceId = @AppearanceId,
	Ph = @Ph,
	SpecificGravity = @SpecificGravity,
	TcssListUrinalysisProteinId = @TcssListUrinalysisProteinId,
	TcssListUrinalysisGlucoseId = @TcssListUrinalysisGlucoseId,
	TcssListUrinalysisBloodId = @TcssListUrinalysisBloodId,
	TcssListUrinalysisRbcId = @TcssListUrinalysisRbcId,
	TcssListUrinalysisWbcId = @TcssListUrinalysisWbcId,
	TcssListUrinalysisEpithId = @TcssListUrinalysisEpithId,
	TcssListUrinalysisCastId = @TcssListUrinalysisCastId,
	TcssListUrinalysisBacteriaId = @TcssListUrinalysisBacteriaId,
	TcssListUrinalysisLeukocyteId = @TcssListUrinalysisLeukocyteId,
	TcssUrinalysisProtein = @TcssUrinalysisProtein,
	TcssUrinalysisGlucose = @TcssUrinalysisGlucose,
	TcssUrinalysisBlood = @TcssUrinalysisBlood,
	TcssUrinalysisRbc = @TcssUrinalysisRbc,
	TcssUrinalysisWbc = @TcssUrinalysisWbc,
	TcssUrinalysisEpith = @TcssUrinalysisEpith,
	TcssUrinalysisCast = @TcssUrinalysisCast,
	TcssUrinalysisBacteria = @TcssUrinalysisBacteria,
	TcssUrinalysisLeukocyte = @TcssUrinalysisLeukocyte
WHERE
	TcssDonorUrinalysisId = @TcssDonorUrinalysisId
GO

GRANT EXEC ON TcssDonorUrinalysisUpdate TO PUBLIC
GO
