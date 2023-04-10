IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisIntestineSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisIntestineSelect'
		DROP Procedure TcssDonorDiagnosisIntestineSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisIntestineSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisIntestineSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisIntestineSelect
**	Desc: Update Data in table TcssDonorDiagnosisIntestine
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddi.TcssDonorDiagnosisIntestineId,
	tddi.LastUpdateStatEmployeeId,
	tddi.LastUpdateDate,
	tddi.TcssDonorId,
	tddi.Comment
FROM dbo.TcssDonorDiagnosisIntestine tddi
WHERE
	tddi.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorDiagnosisIntestineSelect TO PUBLIC
GO
