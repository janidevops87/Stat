IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorUrinalysisInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorUrinalysisInsert'
		DROP Procedure TcssDonorUrinalysisInsert
	END
GO

PRINT 'Creating Procedure TcssDonorUrinalysisInsert'
GO

CREATE PROCEDURE dbo.TcssDonorUrinalysisInsert
(
	@TcssDonorUrinalysisId int output,
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
**	Name: TcssDonorUrinalysisInsert
**	Desc: Insert Data into table TcssDonorUrinalysis
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorUrinalysis
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	SampleDateTime,
	Color,
	AppearanceId,
	Ph,
	SpecificGravity,
	TcssListUrinalysisProteinId,
	TcssListUrinalysisGlucoseId,
	TcssListUrinalysisBloodId,
	TcssListUrinalysisRbcId,
	TcssListUrinalysisWbcId,
	TcssListUrinalysisEpithId,
	TcssListUrinalysisCastId,
	TcssListUrinalysisBacteriaId,
	TcssListUrinalysisLeukocyteId,
	TcssUrinalysisProtein,
	TcssUrinalysisGlucose,
	TcssUrinalysisBlood,
	TcssUrinalysisRbc,
	TcssUrinalysisWbc,
	TcssUrinalysisEpith,
	TcssUrinalysisCast,
	TcssUrinalysisBacteria,
	TcssUrinalysisLeukocyte
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@SampleDateTime,
	@Color,
	@AppearanceId,
	@Ph,
	@SpecificGravity,
	@TcssListUrinalysisProteinId,
	@TcssListUrinalysisGlucoseId,
	@TcssListUrinalysisBloodId,
	@TcssListUrinalysisRbcId,
	@TcssListUrinalysisWbcId,
	@TcssListUrinalysisEpithId,
	@TcssListUrinalysisCastId,
	@TcssListUrinalysisBacteriaId,
	@TcssListUrinalysisLeukocyteId,
	@TcssUrinalysisProtein,
	@TcssUrinalysisGlucose,
	@TcssUrinalysisBlood,
	@TcssUrinalysisRbc,
	@TcssUrinalysisWbc,
	@TcssUrinalysisEpith,
	@TcssUrinalysisCast,
	@TcssUrinalysisBacteria,
	@TcssUrinalysisLeukocyte
)

-- Return the new identity value
SET @TcssDonorUrinalysisId = @@Identity

GO

GRANT EXEC ON TcssDonorUrinalysisInsert TO PUBLIC
GO
