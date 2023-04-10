IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisOtherSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisOtherSelect'
		DROP Procedure TcssDonorDiagnosisOtherSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisOtherSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisOtherSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisOtherSelect
**	Desc: Update Data in table TcssDonorDiagnosisOther
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddo.TcssDonorDiagnosisOtherId,
	tddo.LastUpdateStatEmployeeId,
	tddo.LastUpdateDate,
	tddo.TcssDonorId,
	tddo.TcssListOtherOrganId,
	tddo.Comment
FROM dbo.TcssDonorDiagnosisOther tddo
WHERE
	tddo.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorDiagnosisOtherSelect TO PUBLIC
GO
