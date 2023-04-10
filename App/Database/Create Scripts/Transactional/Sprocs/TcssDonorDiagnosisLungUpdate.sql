IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLungUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLungUpdate'
		DROP Procedure TcssDonorDiagnosisLungUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLungUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLungUpdate
(
	@TcssDonorDiagnosisLungId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@DateIntubated datetime = null,
	@LengthOfRightLung decimal = null,
	@LengthOfLeftLung decimal = null,
	@AorticKnobWidth decimal = null,
	@DiaphragmWidth decimal = null,
	@DistanceRcpaToLcpa decimal = null,
	@ChestCircLandmark decimal = null,
	@TcssListDiagnosisLungChestXrayId int = null,
	@LeftLungComments varchar(5000) = null,
	@RightLungComments varchar(5000) = null,
	@DonorPredictedTotalLungCapacity decimal(18,2)
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLungUpdate
**	Desc: Update Data in table TcssDonorDiagnosisLung
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisLung
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	DateIntubated = @DateIntubated,
	LengthOfRightLung = @LengthOfRightLung,
	LengthOfLeftLung = @LengthOfLeftLung,
	AorticKnobWidth = @AorticKnobWidth,
	DiaphragmWidth = @DiaphragmWidth,
	DistanceRcpaToLcpa = @DistanceRcpaToLcpa,
	ChestCircLandmark = @ChestCircLandmark,
	TcssListDiagnosisLungChestXrayId = @TcssListDiagnosisLungChestXrayId,
	LeftLungComments = @LeftLungComments,
	RightLungComments = @RightLungComments,
	DonorPredictedTotalLungCapacity = @DonorPredictedTotalLungCapacity
WHERE
	TcssDonorDiagnosisLungId = @TcssDonorDiagnosisLungId
GO

GRANT EXEC ON TcssDonorDiagnosisLungUpdate TO PUBLIC
GO
