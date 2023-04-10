IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLiverSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLiverSelect'
		DROP Procedure TcssDonorDiagnosisLiverSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLiverSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLiverSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLiverSelect
**	Desc: Update Data in table TcssDonorDiagnosisLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddl.TcssDonorDiagnosisLiverId,
	tddl.LastUpdateStatEmployeeId,
	tddl.LastUpdateDate,
	tddl.TcssDonorId,
	tddl.TcssListLiverBiopsyId,
	tddl.Comment
FROM dbo.TcssDonorDiagnosisLiver tddl
WHERE
	tddl.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorDiagnosisLiverSelect TO PUBLIC
GO
