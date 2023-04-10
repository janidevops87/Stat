IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLungInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLungInsert'
		DROP Procedure TcssDonorDiagnosisLungInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLungInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLungInsert
(
	@TcssDonorDiagnosisLungId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@DateIntubated datetime = null,
	@LengthOfRightLung decimal(18,2) = null,
	@LengthOfLeftLung decimal(18,2) = null,
	@AorticKnobWidth decimal(18,2) = null,
	@DiaphragmWidth decimal(18,2) = null,
	@DistanceRcpaToLcpa decimal(18,2) = null,
	@ChestCircLandmark decimal(18,2) = null,
	@TcssListDiagnosisLungChestXrayId int = null,
	@LeftLungComments varchar(5000) = null,
	@RightLungComments varchar(5000) = null,
	@DonorPredictedTotalLungCapacity decimal(18,2)
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLungInsert
**	Desc: Insert Data into table TcssDonorDiagnosisLung
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisLung
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	DateIntubated,
	LengthOfRightLung,
	LengthOfLeftLung,
	AorticKnobWidth,
	DiaphragmWidth,
	DistanceRcpaToLcpa,
	ChestCircLandmark,
	TcssListDiagnosisLungChestXrayId,
	LeftLungComments,
	RightLungComments,
	DonorPredictedTotalLungCapacity
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@DateIntubated,
	@LengthOfRightLung,
	@LengthOfLeftLung,
	@AorticKnobWidth,
	@DiaphragmWidth,
	@DistanceRcpaToLcpa,
	@ChestCircLandmark,
	@TcssListDiagnosisLungChestXrayId,
	@LeftLungComments,
	@RightLungComments,
	@DonorPredictedTotalLungCapacity
)

-- Return the new identity value
SET @TcssDonorDiagnosisLungId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisLungInsert TO PUBLIC
GO
