IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLungSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLungSelect'
		DROP Procedure TcssDonorDiagnosisLungSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLungSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLungSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLungSelect
**	Desc: Update Data in table TcssDonorDiagnosisLung
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddl.TcssDonorDiagnosisLungId,
	tddl.LastUpdateStatEmployeeId,
	tddl.LastUpdateDate,
	tddl.TcssDonorId,
	tddl.DateIntubated,
	tddl.LengthOfRightLung,
	tddl.LengthOfLeftLung,
	tddl.AorticKnobWidth,
	tddl.DiaphragmWidth,
	tddl.DistanceRcpaToLcpa,
	tddl.ChestCircLandmark,
	tddl.TcssListDiagnosisLungChestXrayId,
	tddl.LeftLungComments,
	tddl.RightLungComments,
	tddl.DonorPredictedTotalLungCapacity
FROM dbo.TcssDonorDiagnosisLung tddl
WHERE
	tddl.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorDiagnosisLungSelect TO PUBLIC
GO
